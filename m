Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD459703E
	for <lists+linux-api@lfdr.de>; Wed, 21 Aug 2019 05:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfHUDYJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Aug 2019 23:24:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36657 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfHUDYJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Aug 2019 23:24:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so459803pfi.3
        for <linux-api@vger.kernel.org>; Tue, 20 Aug 2019 20:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jR0kd8E/wjsd/vD58hqG03ghBqWwRF++q3yiXcP3i4Q=;
        b=qPX5kwf5x3sbvooqNmhtf5/qc5B1IWhjBxPynFWKkKmBzDXMCAJZWRLKvDdPArq3RI
         Mfok0djgCd2YKvPqhUBBg9wJLXHn7I7qIZNGQ4Aif84+bF24ixmjGxnN0QiMim1vaT09
         9GUdZ8xfh4ci9XixnyG+YcfzEG8yiWIOuK7Okx8ysjUXun8Th7uYK7oCvMfrStI+H+Ky
         3BbqjZolqxn1DZhppI7sLhJ0IUq7C042iSyRvquLw+toahmKllNSnJ+rA6YKeexjzkSx
         oA5XHFN5E4jUNN72kv0lit0Yhn+T1bVzwXFo7swpGEZdUhYIo+zSbXhHPT9g0YpmFqtv
         Whng==
X-Gm-Message-State: APjAAAUzXPvo5n/bNViG3sbBDFg7QF7Bs5In//nnx8r9Hfe3kDGwFdNe
        AVvoNhP1a44tvAMM1c0IRCDdu+L5Lzw=
X-Google-Smtp-Source: APXvYqx02TH2hHNKYt4nqEYXzwAFlFF9WoYyNeM00zGsD5tPI0GF1ZVQQYIRXONJRCZAIgaLN9mj5A==
X-Received: by 2002:a62:e910:: with SMTP id j16mr34286562pfh.123.1566357848815;
        Tue, 20 Aug 2019 20:24:08 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id c13sm22739750pfi.17.2019.08.20.20.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 20:24:07 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:24:06 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v5 1/9] fpga: dfl: make init callback optional
Message-ID: <20190821032406.GA28625@archbox>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
 <1565578204-13969-2-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565578204-13969-2-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On Mon, Aug 12, 2019 at 10:49:56AM +0800, Wu Hao wrote:
> This patch makes init callback of sub features optional. With
> this change, people don't need to prepare any empty init callback.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index c0512af..96a2b82 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -271,11 +271,13 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
>  				     struct dfl_feature *feature,
>  				     struct dfl_feature_driver *drv)
>  {
> -	int ret;
> +	int ret = 0;
>  
> -	ret = drv->ops->init(pdev, feature);
> -	if (ret)
> -		return ret;
> +	if (drv->ops->init) {
> +		ret = drv->ops->init(pdev, feature);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	feature->ops = drv->ops;

You could swap it around maybe like so:

int dfl_feature_instance_init() ...
{
	feature->ops = drv->ops;
	if (drv->ops->init)
		return drv->ops->init(pdev, feature);

	return 0;
}

With the caveat that feature->ops gets always set ...

Your call.

Thanks,
Moritz
