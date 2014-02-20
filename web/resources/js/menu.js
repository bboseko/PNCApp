
function selectFunctionalityLink(link) {
    jQuery("#functionalityList").find(".ui-state-active").removeClass("ui-state-active");
    if (link) {
        jQuery(link).addClass("ui-state-active");
    }
}

