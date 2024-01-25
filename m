Return-Path: <linux-api+bounces-642-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02A83BCB5
	for <lists+linux-api@lfdr.de>; Thu, 25 Jan 2024 10:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1011C28482
	for <lists+linux-api@lfdr.de>; Thu, 25 Jan 2024 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1181BC50;
	Thu, 25 Jan 2024 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f7Xz34JG"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC841BC5A
	for <linux-api@vger.kernel.org>; Thu, 25 Jan 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173168; cv=none; b=ebE7s9zTrb23eXHyVe2YltyqlD1ZT55e94qJErpDV+20sNxZr2zb+lWDlZT1zYg1AKCA1gcLHAm/dU+bFYiS9NNqSAn76e9/dBE4CHGFzGYxsGAfvkNmxy/rAUgq/SASJTlRq2j/nBW3UF7ZezEEaxGBQfMk9Z3SG3ZrfYMQbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173168; c=relaxed/simple;
	bh=BkonSwvBSVAeVSj+/yM8srRNCH2JQwmNT8fjAm5M6zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLKshNQJygilt7UV66G57QPkWMvM53BiIlx7bCrivAQ23KSHSLjeD5ATuj2qkrxGzVDfyjVTtg49fZnwAK3niiwYxqgIe1C29Cc/gYjwGM7SHX3hQmhWNdR+WXF6RogOGBI8xAfmqeprvVBFs8gnq+djeNH/R/Dyv48oGUUhEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f7Xz34JG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so82690805e9.1
        for <linux-api@vger.kernel.org>; Thu, 25 Jan 2024 00:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706173165; x=1706777965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erSKDlQR5+PNHS3860P/F3Nu4Jwial5atVHAuQbFvdc=;
        b=f7Xz34JGnQd430h9kD6EFEyb4rllPrTiM+1kG/iH9PbzGUDMgLYnkyurB337Ne8nS1
         A4mmSWf59FDLXosdNjZ7arSXgp1DGran4RkkbEHdgJ6Lkx4jIFjSIUSfD5FflHXDpWx6
         XK4Ypi2e7Y6NZRRmGEzvCfg8dy9E2dxuFtt0IdUwNpKfMn0MlWojVc+0RaSHNORRY1wm
         j1tmYr943sanakZXVpGyDVDGOiDxZlZhRuWQ9DSLVd9uL6ZvvcxBHhzw4ETY4qRWkTBB
         HS4dnhen0Kb3hi3p6QYq6bf/UkQTk7og1kSzmFiFw7szfxRC7lghDwQv1DpcmTdCaxlR
         Q9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173165; x=1706777965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erSKDlQR5+PNHS3860P/F3Nu4Jwial5atVHAuQbFvdc=;
        b=CHuB3xVjKpV5otCu37FLFkKH9GNMkCLyZsFhupWHOgmdtWZExAwpaK+l8zCL1Irh1p
         NegKnvARPjFLgB18jFJhtYgfwpcekNaHGKhyvcXSEOQyOdBibUzGzZ/5emz/fYm7FGWh
         FUonZST9gAsbo7afxmx6hYdXhkpFoSpIJK5A7Xyvg+X8mlrRbBvsFLDMv3QYA6OOYIPh
         VQ6vHuCOmyElyRQVCIcJdgyS8y/Nupcip6uEWSHq2A4EYTk44lZ4RdzyXO2uMQjdvOoc
         6S0igsVbMGQYFAIqNYbvBJ6+IQndV4Ap+GGZQYX/H8kwQ8u2CPz3xLa/RZwzhpMippn0
         NcHA==
X-Gm-Message-State: AOJu0YwTeQrraRdctqpBmkGh1YPtvp8McF4kHv/ONIhFBWHAtjkrNR0E
	GeGCf0c+1Q//GmSlQqngYCcknSK6U0HwmC4zKw6O4DUrqyoEQC+ZcMwNqSKl1ZA=
X-Google-Smtp-Source: AGHT+IE8NLFBdP26KgzjN7t3Eo6+D2rQKQrXWvEBi8qCf1k9BJWCKOFGza00RXHRn0+C9ey1X1qo3Q==
X-Received: by 2002:a05:600c:1c99:b0:40e:cc93:2f6b with SMTP id k25-20020a05600c1c9900b0040ecc932f6bmr311011wms.151.1706173164937;
        Thu, 25 Jan 2024 00:59:24 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7589:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7589:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b0040e5945307esm1786225wmo.40.2024.01.25.00.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 00:59:24 -0800 (PST)
Message-ID: <f6448d5a-c04a-4d8f-9672-a14aa3061c3e@suse.com>
Date: Thu, 25 Jan 2024 10:59:23 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/9] ntsync: Introduce NTSYNC_IOC_PUT_SEM.
Content-Language: en-US
To: Elizabeth Figura <zfigura@codeweavers.com>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: wine-devel@winehq.org, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Wolfram Sang <wsa@kernel.org>,
 Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-5-zfigura@codeweavers.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240124004028.16826-5-zfigura@codeweavers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24.01.24 г. 2:40 ч., Elizabeth Figura wrote:
> This corresponds to the NT syscall NtReleaseSemaphore().
> 
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> ---
>   drivers/misc/ntsync.c       | 76 +++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/ntsync.h |  2 +
>   2 files changed, 78 insertions(+)
> 
> diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> index 3287b94be351..d1c91c2a4f1a 100644
> --- a/drivers/misc/ntsync.c
> +++ b/drivers/misc/ntsync.c
> @@ -21,9 +21,11 @@ enum ntsync_type {
>   struct ntsync_obj {
>   	struct rcu_head rhead;
>   	struct kref refcount;
> +	spinlock_t lock;
>   
>   	enum ntsync_type type;
>   
> +	/* The following fields are protected by the object lock. */
>   	union {
>   		struct {
>   			__u32 count;
> @@ -36,6 +38,19 @@ struct ntsync_device {
>   	struct xarray objects;
>   };
>   
> +static struct ntsync_obj *get_obj(struct ntsync_device *dev, __u32 id)
> +{
> +	struct ntsync_obj *obj;
> +
> +	rcu_read_lock();
> +	obj = xa_load(&dev->objects, id);
> +	if (obj && !kref_get_unless_zero(&obj->refcount))
> +		obj = NULL;
> +	rcu_read_unlock();
> +
> +	return obj;
> +}
> +
>   static void destroy_obj(struct kref *ref)
>   {
>   	struct ntsync_obj *obj = container_of(ref, struct ntsync_obj, refcount);
> @@ -48,6 +63,18 @@ static void put_obj(struct ntsync_obj *obj)
>   	kref_put(&obj->refcount, destroy_obj);
>   }
>   
> +static struct ntsync_obj *get_obj_typed(struct ntsync_device *dev, __u32 id,
> +					enum ntsync_type type)
> +{
> +	struct ntsync_obj *obj = get_obj(dev, id);
> +
> +	if (obj && obj->type != type) {
> +		put_obj(obj);
> +		return NULL;
> +	}
> +	return obj;
> +}
> +
>   static int ntsync_char_open(struct inode *inode, struct file *file)
>   {
>   	struct ntsync_device *dev;
> @@ -81,6 +108,7 @@ static int ntsync_char_release(struct inode *inode, struct file *file)
>   static void init_obj(struct ntsync_obj *obj)
>   {
>   	kref_init(&obj->refcount);
> +	spin_lock_init(&obj->lock);
>   }
>   
>   static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
> @@ -131,6 +159,52 @@ static int ntsync_delete(struct ntsync_device *dev, void __user *argp)
>   	return 0;
>   }
>   
> +/*
> + * Actually change the semaphore state, returning -EOVERFLOW if it is made
> + * invalid.
> + */
> +static int put_sem_state(struct ntsync_obj *sem, __u32 count)

nit: Just a general observation - those functions that contains the 
specific type in their name could take the exact object i.e struct ntsem 
which will make the code somewhat more clear. Of course, this would mean 
that the struct definition in patch 3 should be changed to also contain 
a tag name.


