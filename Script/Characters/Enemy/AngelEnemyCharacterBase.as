class AAngelEnemyChracterBase : AAngelCharacterBase
{
    UPROPERTY(BlueprintReadOnly)
    bool bHighLighted = false;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        
    }

    UFUNCTION(BlueprintOverride)
    void HighLightActor()
    {
        bHighLighted = true;
    }

    UFUNCTION(BlueprintOverride)
    void UnHighLightActor()
    {
        bHighLighted = false;
    }





}