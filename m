Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208F21692A
	for <lists+linux-api@lfdr.de>; Tue,  7 May 2019 19:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfEGR1f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 May 2019 13:27:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46514 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfEGR1f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 May 2019 13:27:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi2so8504876plb.13
        for <linux-api@vger.kernel.org>; Tue, 07 May 2019 10:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2GznVx19aBlSBwrY4k/2U/6uFTPH38asKDdyd9v7fLM=;
        b=Noo98tfnpD75annV8wMOSbQMRUvbYW2UQaX6HX1ylK7489j6q9GtU07+WOBu/9eV6R
         iaKU2QDJoC38tRPbKNTsLas9nKsS9M4ioaTwnuXDAsSJ28Ri6jGz1yAGfTNxnfD/bnuS
         iO8GvUHNVQ4c6xhiQL9ZACEAox9ydGwELdOU+K6kieFvRJ0k0NGYoV/DV5cyikrfqVQL
         tYQUTLTv1HaxxK99J+ONxK5Vwm+QNvqz/EIEf1k/0SkL4gIpKCMWxFJkydc5A0AfusOy
         ivOdz+84iw5bCiRLn0AhGNImmMDjR2rRIVONIwyVFAePRT8NhRzI8d7aC4I8I1QuYT50
         zjIg==
X-Gm-Message-State: APjAAAUwTWEC6uAGp5F4q7elgKThh2CQDGrhqfM7k6hDo7P8F4+4Ze2o
        IzwJWw00oKlHTuSn6c8OcvctsIOU7+s5aQ==
X-Google-Smtp-Source: APXvYqxUpLLcdT6fy8v+mso0WDW3BBsgS4L5Z3JtBQ2F2YruBQUpMC1dM86GInYA0WCXOP2JhVj7qg==
X-Received: by 2002:a17:902:100a:: with SMTP id b10mr36618902pla.239.1557250054263;
        Tue, 07 May 2019 10:27:34 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id y3sm22725826pge.7.2019.05.07.10.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:27:33 -0700 (PDT)
Date:   Tue, 7 May 2019 10:27:32 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 03/18] fpga: dfl: fme: align PR buffer size per PR
 datawidth
Message-ID: <20190507172732.GB26690@archbox>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-4-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556528151-17221-4-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 04:55:36PM +0800, Wu Hao wrote:
> Current driver checks if input bitstream file size is aligned or
> not per PR data width (default 32bits). It requires one additional
> step for end user when they generate the bitstream file, padding
> extra zeros to bitstream file to align its size per PR data width,
> but they don't have to as hardware will drop extra padding bytes
> automatically.
> 
> In order to simplify the user steps, this patch aligns PR buffer
> size per PR data width in driver, to allow user to pass unaligned
> size bitstream files to driver.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-pr.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index 6ec0f09..3c71dc3 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -74,6 +74,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  	struct dfl_fme *fme;
>  	unsigned long minsz;
>  	void *buf = NULL;
> +	size_t length;
>  	int ret = 0;
>  	u64 v;
>  
> @@ -85,9 +86,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  	if (port_pr.argsz < minsz || port_pr.flags)
>  		return -EINVAL;
>  
> -	if (!IS_ALIGNED(port_pr.buffer_size, 4))
> -		return -EINVAL;
> -
>  	/* get fme header region */
>  	fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
>  					       FME_FEATURE_ID_HEADER);
> @@ -103,7 +101,13 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  		       port_pr.buffer_size))
>  		return -EFAULT;
>  
> -	buf = vmalloc(port_pr.buffer_size);
> +	/*
> +	 * align PR buffer per PR bandwidth, as HW ignores the extra padding
> +	 * data automatically.
> +	 */
> +	length = ALIGN(port_pr.buffer_size, 4);
> +
> +	buf = vmalloc(length);
>  	if (!buf)
>  		return -ENOMEM;
>  
> @@ -140,7 +144,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  	fpga_image_info_free(region->info);
>  
>  	info->buf = buf;
> -	info->count = port_pr.buffer_size;
> +	info->count = length;
>  	info->region_id = port_pr.port_id;
>  	region->info = info;
>  
> -- 
> 1.8.3.1
> 
