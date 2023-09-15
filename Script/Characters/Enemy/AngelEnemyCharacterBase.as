class AAngelEnemyChracterBase : AAngelCharacterBase
{
    UPROPERTY(DefaultComponent)
    UAngelEnemyComponent AngelEnemyComponent;
    default AngelEnemyComponent.bHighLighted = false;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        
    }

    UFUNCTION()
    void HighLightActor()
    {
         AngelEnemyComponent.bHighLighted = true;
    }

    UFUNCTION()
    void UnHighLightActor()
    {
         AngelEnemyComponent.bHighLighted = false;
    }





}