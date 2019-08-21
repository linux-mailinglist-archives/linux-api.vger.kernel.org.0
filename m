Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAD297051
	for <lists+linux-api@lfdr.de>; Wed, 21 Aug 2019 05:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfHUD2u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Aug 2019 23:28:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40821 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHUD2t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Aug 2019 23:28:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id w16so458737pfn.7
        for <linux-api@vger.kernel.org>; Tue, 20 Aug 2019 20:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O3GThF6qgBBSbkZwWRayRKD2MaFCahuUCpZzRTM/BR0=;
        b=huuHIXxh751ZQWDkuNF4WamMLUDEAPlJFEbisLRDOaAQfC1CF+UOwMmSV2SzLh440l
         aBrymETyyes7tcsmUSc8Qk1KGJUu53dp4juJe/p1lbEInGo/wbLyQooZdS5sDN/Um3tG
         H40tTSV3Wu9IZjdQW+fUywz8EwP+rm++W5sEVLciDInjEmT2Jt0vRqGwGb6m+BB+C5jL
         rkP+QvZYsl95RdlGnwF/dt4maZ4vAXpeLPQ4KoamIeCfaqXWK6sQdzGbx65bUMnn1ZxL
         BIIea0iia/GWU6D64LwjNVQI9rX+X5CgVoTJJog6aDTc+oCSRAzrKPSW2Dn5YtNNivhF
         fktQ==
X-Gm-Message-State: APjAAAXpzHDgHFXuqJoKbZlseb9cuS8Xg8RiTLVfzUlWXR7xU5tVAViR
        lQDuFtL7U6hZjTAV+7tHeYiCFg==
X-Google-Smtp-Source: APXvYqyumJYFLBjxpJaHCd0soNjhTEab8KG/HJBqQQUsiVKxWCzrF4y9BztwfhrVQnKH/j++9l8dVQ==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr3221239pju.117.1566358129061;
        Tue, 20 Aug 2019 20:28:49 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id b6sm18402890pgq.26.2019.08.20.20.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 20:28:48 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:28:47 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v5 2/9] fpga: dfl: fme: convert platform_driver to use
 dev_groups
Message-ID: <20190821032847.GB28625@archbox>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
 <1565578204-13969-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565578204-13969-3-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Hao,

On Mon, Aug 12, 2019 at 10:49:57AM +0800, Wu Hao wrote:
> This patch takes advantage of driver core which helps to create
> and remove sysfs attribute files, so there is no need to register
> sysfs entries manually in dfl-fme platform river code.
Nit: s/river/driver
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-main.c | 29 ++---------------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index f033f1c..bf8114d 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -129,30 +129,6 @@ static ssize_t socket_id_show(struct device *dev,
>  };
>  ATTRIBUTE_GROUPS(fme_hdr);
>  
> -static int fme_hdr_init(struct platform_device *pdev,
> -			struct dfl_feature *feature)
> -{
> -	void __iomem *base = feature->ioaddr;
> -	int ret;
> -
> -	dev_dbg(&pdev->dev, "FME HDR Init.\n");
> -	dev_dbg(&pdev->dev, "FME cap %llx.\n",
> -		(unsigned long long)readq(base + FME_HDR_CAP));
> -
> -	ret = device_add_groups(&pdev->dev, fme_hdr_groups);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static void fme_hdr_uinit(struct platform_device *pdev,
> -			  struct dfl_feature *feature)
> -{
> -	dev_dbg(&pdev->dev, "FME HDR UInit.\n");
> -	device_remove_groups(&pdev->dev, fme_hdr_groups);
> -}
> -
>  static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
>  				       unsigned long arg)
>  {
> @@ -199,8 +175,6 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
>  };
>  
>  static const struct dfl_feature_ops fme_hdr_ops = {
> -	.init = fme_hdr_init,
> -	.uinit = fme_hdr_uinit,
>  	.ioctl = fme_hdr_ioctl,
>  };
>  
> @@ -361,7 +335,8 @@ static int fme_remove(struct platform_device *pdev)
>  
>  static struct platform_driver fme_driver = {
>  	.driver	= {
> -		.name    = DFL_FPGA_FEATURE_DEV_FME,
> +		.name       = DFL_FPGA_FEATURE_DEV_FME,
> +		.dev_groups = fme_hdr_groups,
>  	},
>  	.probe   = fme_probe,
>  	.remove  = fme_remove,
> -- 
> 1.8.3.1
> 
Thanks,
Moritz
