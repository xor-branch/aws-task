class CommentsController < ApplicationController
  before_action :set_blog, only: [:create, :edit, :update]
  # Une action pour enregistrer et publier un commentaire.
 def create
   # Recherchez Blog à partir de la valeur du paramètre et créez-le en tant que commentaires associés à Blog.
   @blog = Blog.find(params[:blog_id])
   @comment = @blog.comments.build(comment_params)
   # Changer le format en fonction de la demande du client
   respond_to do |format|
     if @comment.save
       format.js { render :index }
       #format.html { redirect_to blog_path(@blog) }
     else
       format.html { redirect_to blog_path(@blog), notice: 'Impossible de publier ...' }
     end
   end
 end
 def edit
    @comment = @blog.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'commentaire modifié'
      format.js { render :edit }
    end
  end
  def update
    @comment = @blog.comments.find(params[:id])
      respond_to do |format|
        if @comment.update(comment_params)
          flash.now[:notice] = 'Le commentaire a été modifié'
          format.js { render :index }
        else
          flash.now[:notice] = 'Le modificateur de commentaire a échoué'
          format.js { render :edit_error }
        end
      end
    end
    def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'Commentaire supprimé'
      format.js { render :index }
    end
  end
 private
 # Paramètres forts
 def comment_params
   params.require(:comment).permit(:blog_id, :content)
 end
 def set_blog
    @blog = Blog.find(params[:blog_id])
  end
end
