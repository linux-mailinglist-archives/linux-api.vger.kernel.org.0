Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D198E729FCE
	for <lists+linux-api@lfdr.de>; Fri,  9 Jun 2023 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjFIQOH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Jun 2023 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242079AbjFIQOE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Jun 2023 12:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC42226B9
        for <linux-api@vger.kernel.org>; Fri,  9 Jun 2023 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686327202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0D0fx1mFB/JV/q+hvvzbZ4BbnjjH4XlfjQ5soZ7CGmE=;
        b=D8S7a501JNFuJdUf0CSInZL7Pme5X0QodUWsUfwJYD62fFeAZwyqtRDYAW76bEBTzATnxX
        RefTsHQxSeqIpeimeMo+naH3y8JoCftroQTmKkpJnbmA9ni6VumO3ckoS7PRqtQDTQdoeS
        pbQ/DmePAM6lXX7it15JPa+IeEpRjPE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-nQRmTNXDPKePnvM3CcWwtQ-1; Fri, 09 Jun 2023 12:13:21 -0400
X-MC-Unique: nQRmTNXDPKePnvM3CcWwtQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7e8c24a92so7531845e9.0
        for <linux-api@vger.kernel.org>; Fri, 09 Jun 2023 09:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327200; x=1688919200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0D0fx1mFB/JV/q+hvvzbZ4BbnjjH4XlfjQ5soZ7CGmE=;
        b=GAy/dH6ORRIOTZceTemRoU0fTpAihYBu0x3OGUuLGtx+vQE29cJoc/3XP/ikolr8S2
         pcAqWA5O96eI12AcT4qtTaaoaQeRoV654MQUZNCRA0ViHhsQrw3SB3w53NM3nh9Hd6gZ
         5HbE0VNILdbYjNErpPl0Gt9Ag9EXYT0YeeUvCFU0brId03nLsBKt4bBojN/03NuC6cpW
         XefGOt2dswyNYtYpI1/TWqGRHhAY6YsWpMZOxCOMo1zdXouS+iDKJZXihP4Pu5o6BxQJ
         A6ymQuvDWjX7vcUCHmUaw3m54iTn4iTQpY6BvVfXYvglUGXDQmeTAcTF7XpR+Nme4lqg
         hXNQ==
X-Gm-Message-State: AC+VfDyZqIce+GP1zeod2d9kxlQNIUlFbfOQm1hgMPLi8rW4CtKuuTCw
        vXwxldew2f9NevZyxts5b50V6u88Ew/W8QW7gcllHtxdDc5FLo14K6e2Xb0mOGMNHzgGbGvD/dB
        kYlyPpnugEf68spXx8vJS
X-Received: by 2002:a1c:7903:0:b0:3f5:60b:33 with SMTP id l3-20020a1c7903000000b003f5060b0033mr1210773wme.5.1686327199939;
        Fri, 09 Jun 2023 09:13:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6PvTuWonpbAPcqcGK+Qy57af6UFWRA4xTXacgkC8KC6k77AUEeUdQkIRV+Tm1Yn4p/8VPllg==
X-Received: by 2002:a1c:7903:0:b0:3f5:60b:33 with SMTP id l3-20020a1c7903000000b003f5060b0033mr1210743wme.5.1686327199617;
        Fri, 09 Jun 2023 09:13:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id f26-20020a1c6a1a000000b003f7ea771b5dsm3187488wmc.1.2023.06.09.09.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:13:19 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:13:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com,
        Lei Yang <leiyang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Gautam Dawar <gdawar@xilinx.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>, linux-api@vger.kernel.org,
        Liuxiangdong <liuxiangdong5@huawei.com>,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com,
        Shannon Nelson <snelson@pensando.io>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Cindy Lu <lulu@redhat.com>, si-wei.liu@oracle.com,
        Harpreet Singh Anand <hanand@xilinx.com>
Subject: Re: [PATCH v2 2/4] vdpa: accept
 VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
Message-ID: <20230609121244-mutt-send-email-mst@kernel.org>
References: <20230609092127.170673-1-eperezma@redhat.com>
 <20230609092127.170673-3-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609092127.170673-3-eperezma@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 09, 2023 at 11:21:25AM +0200, Eugenio Pérez wrote:
> Accepting VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature if
> userland sets it.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> Acked-by: Shannon Nelson <shannon.nelson@amd.com>

I don't get it, so all vdpa devices accept this automatically?
Should this not be up to the parent?

> ---
>  drivers/vhost/vdpa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bf77924d5b60..a3204406b73d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -680,7 +680,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  			return -EFAULT;
>  		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
>  				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> -				 BIT_ULL(VHOST_BACKEND_F_RESUME)))
> +				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
> +				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
>  			return -EOPNOTSUPP;
>  		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>  		     !vhost_vdpa_can_suspend(v))
> -- 
> 2.31.1

