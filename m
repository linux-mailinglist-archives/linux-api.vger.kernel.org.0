Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7621833A23B
	for <lists+linux-api@lfdr.de>; Sun, 14 Mar 2021 02:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCNBrA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 13 Mar 2021 20:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhCNBqg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 13 Mar 2021 20:46:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69EF864EBA;
        Sun, 14 Mar 2021 01:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615686395;
        bh=OzIper+pj1xZH9n9eLVpLqx5W00LXU5WB4+Tu9P1UbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoQSV6siFzoZXZowtmxqkxcoaXJb2Jg/vN/vQF3G9Gg6VFw1CvZmS8giq2/4ObT1X
         bRRG4sMFQxTjr9tEogRqy6dV5Vb+3zYhHZKJbLqn36wNcSvVorDSAwCncSZUhBJ0b8
         QVOYKZ6pxUsvX5U1l2s2E++zrDrSNF16IcJaFm3xtXGqPIJK9ODqM+o9QgWc4dnjf5
         pbb0luyTfDHFXku8erOGAoD5yS40sDUjeMVyksceMqa0tPsHtnRthOmEMJB5VxHjJ1
         yrYnapEyzdCZ+Vs2T4f7krzEDMYjbJ3xCL3qHd4U0q76tXGbRZtdl60TZ6vzhVSsvC
         0/g0CA0GgyKMQ==
Date:   Sun, 14 Mar 2021 09:46:29 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-api@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com
Subject: Re: [PATCH 2/2] usb: webcam: Invalid size of Processing Unit
 Descriptor
Message-ID: <20210314014629.GA17526@b29397-desktop>
References: <20210308102735.9251-1-pawell@gli-login.cadence.com>
 <20210308102735.9251-2-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308102735.9251-2-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 21-03-08 11:27:35, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> According with USB Device Class Definition for Video Device the
> Processing Unit Descriptor bLength should be 12 (10 + bmControlSize),
> but it has 11.

Does the reason forget filling bmVideoStandards entry?

Peter
> 
> Invalid length caused that Processing Unit Descriptor Test Video form
> CV tool failed. To fix this issue patch adds bmVideoStandards into
> uvc_processing_unit_descriptor structure.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  include/uapi/linux/usb/video.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
> index d854cb19c42c..2a54e8fdd341 100644
> --- a/include/uapi/linux/usb/video.h
> +++ b/include/uapi/linux/usb/video.h
> @@ -302,6 +302,7 @@ struct uvc_processing_unit_descriptor {
>  	__u8   bControlSize;
>  	__u8   bmControls[2];
>  	__u8   iProcessing;
> +	__u8   bmVideoStandards;
>  } __attribute__((__packed__));
>  
>  #define UVC_DT_PROCESSING_UNIT_SIZE(n)			(9+(n))
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

