Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3695E88379
	for <lists+linux-api@lfdr.de>; Fri,  9 Aug 2019 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHITvw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Aug 2019 15:51:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42075 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfHITvw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Aug 2019 15:51:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so45401037plb.9
        for <linux-api@vger.kernel.org>; Fri, 09 Aug 2019 12:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UTaxKlCQs2rMVT6dmaq6PY1yYeN42Xa3IY6ykXZ99rU=;
        b=XfcvYSZSfsoJCOAnXj/IW2wV2tFH6o8R0h49QuYyNECazVxuWhU+60lA7izBX+r6Cg
         oDioaNMYxC3usabaKwj+cbiDNykeVFDcetepL55epkDtPoztQPlT25AuQIEr6o/20ExT
         je04co39SDYQ07iaPEeRfIyw5USsp0OX7fZ/iK+858EDX6oHpmr9UnorCnyJLPUf9vcb
         QBndKnZ6YZKgK93WCbKdNfjJCR30/jQBXKAFietAFKBtEEmSQmEUyZWO1LDBhUqEtRUj
         bSevWdsfriROL63BA53WAxqiIVUa0+DlKQZbQueeBkgBUTBJWRs4e/gszEPAhP0LLHcn
         zbPw==
X-Gm-Message-State: APjAAAXjwHDB861BV3k3wIewY/J9AVGZwTn084CwQSLQX0SOCfZG9E1n
        a1DReOdN25xWgb6knjXwDzLb/Ymql+g=
X-Google-Smtp-Source: APXvYqwJIsjHm9/3r8AONPEu+5ScceQ+yC2jFmx3vHPuhwPESekE53KUkPxX83lynaQO8jTUwealAA==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr21482416plp.59.1565380311248;
        Fri, 09 Aug 2019 12:51:51 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id a15sm137192004pfg.102.2019.08.09.12.51.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 12:51:50 -0700 (PDT)
Date:   Fri, 9 Aug 2019 12:51:49 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v4 08/12] fpga: dfl: make uinit callback optional
Message-ID: <20190809195149.GA2788@archbox>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
 <1564914022-3710-9-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564914022-3710-9-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Aug 04, 2019 at 06:20:18PM +0800, Wu Hao wrote:
> This patch makes uinit callback of sub features optional. With
> this change, people don't need to prepare any empty uinit callback.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 87eaef6..c0512af 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -259,7 +259,8 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
>  
>  	dfl_fpga_dev_for_each_feature(pdata, feature)
>  		if (feature->ops) {
> -			feature->ops->uinit(pdev, feature);
> +			if (feature->ops->uinit)
> +				feature->ops->uinit(pdev, feature);
>  			feature->ops = NULL;
>  		}
>  }
> -- 
> 1.8.3.1
> 
