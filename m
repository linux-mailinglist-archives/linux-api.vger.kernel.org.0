Return-Path: <linux-api+bounces-4530-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6853B2E136
	for <lists+linux-api@lfdr.de>; Wed, 20 Aug 2025 17:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B60A218D7
	for <lists+linux-api@lfdr.de>; Wed, 20 Aug 2025 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98A326D71;
	Wed, 20 Aug 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPoisYSV"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6132DFA32
	for <linux-api@vger.kernel.org>; Wed, 20 Aug 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703056; cv=none; b=OcB8DOe35/wnolnp39TLFN5dLf8KOxh+Wb9GIGAPthMmkULF8PcOp/N7j/Rp/RJKeeOS3iBKk0ye+G7GuoPNUWGRGxI4IH+rvexaHGVEP3nIeSyKOMhxJggThWGM/Og8d0skQoczCrOKgMbB0MTgPZnRCbpJrAG6faqUmGe/Ihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703056; c=relaxed/simple;
	bh=W4duEWOlM+udE5VNJ/zPTR+3z61gEew4hVyTyQpHZM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGehn+ilhmLSmSsPO1Q05YUvcO1s4N6u7cxec2Cfp4JiKw8KxMiVzP40Z3fHyLP0DMaQMsoaJljYRcCdwYaIwnto4mqrGibNiHMnAwJyXMQbcBUdvPlTlMDqB8iEltihNaI0WJ/lKtj2mOEEMV4BfgIIc/cJvVN6A22bNJMqJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPoisYSV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755703053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwfU+IsVElt3h1n12yQUuhxkyKNo90VrK/DGR70vyVI=;
	b=dPoisYSV/fK/fqqtztdIi9ArPThQTZgWEqzOmSFzZuoGSCDo+sr38PJP37vuHYOgUVvzOl
	OJKz6R/SvMK1sW1BDPbxSrMuY/4uFrjamlm4XXdtfj+Bnik5t1o3g6ecCW6BOYK9svgJiV
	m4whFb2AQOXRmJ++QYXJU2Nh9zul/Ik=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-nhmi3pTPOISSC6bFkkgX1g-1; Wed, 20 Aug 2025 11:17:32 -0400
X-MC-Unique: nhmi3pTPOISSC6bFkkgX1g-1
X-Mimecast-MFC-AGG-ID: nhmi3pTPOISSC6bFkkgX1g_1755703052
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109bccebaso54561cf.2
        for <linux-api@vger.kernel.org>; Wed, 20 Aug 2025 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703052; x=1756307852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwfU+IsVElt3h1n12yQUuhxkyKNo90VrK/DGR70vyVI=;
        b=l9m4vcPmo4AFXoKSu38PX+VxnY84Cjh0LezyIsjVL2HPdaIkoT2Th8qh+Au2QCGYp0
         JQ9julM/3WLlR8CTntS5i2wAKf55/M0gK7HpBpi/VJYBex8By+IX2HhsXIIOw713VsL1
         q7OxlNM5D6IroOwFMU+D1tu+BBlI+lYE9iSZmlDA3OBuOCPj3TGGBxbWjZZINjNb6xPL
         xh2MB1xBszswcBywlKitCzzQLIZsJrAi98fbByNslIYR94SIHOLLpd9ojtDuQNav7/TC
         k4dFp1VD4auPwB8W13eHixq+1/6qK02Cl/9bm2MXxbHMG/qgAqzUAVHh4+vYl6BOoVhZ
         NYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLMfUm7caNRjJv0xuMlLq+pjx94NZWOAqBHsov7C+LFn8IYqrYIm+fcYLaQZBbMkJtO7dlDEGwias=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNmVHil59mr2VrfedBPIwNUyERf42ytffAk3CKFv2csDsJINJ
	bxgm+NVREMFlxZYPsM/Drd+bDRB8B79pPkVx8w7yGjinGZogt6YFp0FgN+H3KTugLBNnbbISkK+
	AHpdzfg9FBNDVwnJH/cs1VnAdJKeMfu8OavO3omrrg5pPjjnU900AfAgD1tEiSYdv2ZQXRyVvga
	D3xuJ01O1j2TgURkdaOniVsSfuCSZSxT7SVQln
X-Gm-Gg: ASbGnctS4UwpiOx0o3boKMJq4RrFkIFSIJo6qPFKqiQxS7jznl82lXChljopQdsWyWi
	kZMvil65LZ0lVwBcSWb4+mzXSNTiPQw/m/B0v5f2AWjm7qQmzZicM9rl3YHO7DmU04D1H5gOQAk
	sTVYw7ciqSDdyocbehLlf4uzMd4WuJ5O1NiKSLMzQf0wgaO+xBdv64
X-Received: by 2002:a05:622a:5c93:b0:4af:203f:73e9 with SMTP id d75a77b69052e-4b291a45948mr38268791cf.3.1755703051777;
        Wed, 20 Aug 2025 08:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgNNXQPsAlJCg5PdYpqbUQjKk2La90rXTiB/Xg+AFCp6PDdl0eXQ9VodkzneYLfMLO6npPB65IGBnQ/QO7tyQ=
X-Received: by 2002:a05:622a:5c93:b0:4af:203f:73e9 with SMTP id
 d75a77b69052e-4b291a45948mr38268261cf.3.1755703051224; Wed, 20 Aug 2025
 08:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815121459.3391223-1-lichliu@redhat.com>
In-Reply-To: <20250815121459.3391223-1-lichliu@redhat.com>
From: Lichen Liu <lichliu@redhat.com>
Date: Wed, 20 Aug 2025 23:17:20 +0800
X-Gm-Features: Ac12FXz5J-qsSNe_dCy4Is9oFh6XR_1xsHJhV6_kkHN0LaUVbdz8uoGPSmN-wtU
Message-ID: <CAPmSd0OHB3orya=3V1icz4ZzOoAwHuWTqON_Dk+EaEcACtVtbg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	safinaskar@zohomail.com, kexec@lists.infradead.org, rob@landley.net, 
	weilongchen@huawei.com, cyphar@cyphar.com, linux-api@vger.kernel.org, 
	zohar@linux.ibm.com, stefanb@linux.ibm.com, initramfs@vger.kernel.org, 
	corbet@lwn.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all, do you have any comments for this v2 patch?

Thanks,
Lichen

On Fri, Aug 15, 2025 at 8:15=E2=80=AFPM Lichen Liu <lichliu@redhat.com> wro=
te:
>
> When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> By default, a tmpfs mount is limited to using 50% of the available RAM
> for its content. This can be problematic in memory-constrained
> environments, particularly during a kdump capture.
>
> In a kdump scenario, the capture kernel boots with a limited amount of
> memory specified by the 'crashkernel' parameter. If the initramfs is
> large, it may fail to unpack into the tmpfs rootfs due to insufficient
> space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> memory must be available for the mount. This leads to an OOM failure
> during the early boot process, preventing a successful crash dump.
>
> This patch introduces a new kernel command-line parameter, rootfsflags,
> which allows passing specific mount options directly to the rootfs when
> it is first mounted. This gives users control over the rootfs behavior.
>
> For example, a user can now specify rootfsflags=3Dsize=3D75% to allow the
> tmpfs to use up to 75% of the available memory. This can significantly
> reduce the memory pressure for kdump.
>
> Consider a practical example:
>
> To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
> the default 50% limit, this requires a memory pool of 96MB to be
> available for the tmpfs mount. The total memory requirement is therefore
> approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacked
> kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) =E2=89=88 220MB.
>
> By using rootfsflags=3Dsize=3D75%, the memory pool required for the 48MB
> tmpfs is reduced to 48MB / 0.75 =3D 64MB. This reduces the total memory
> requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
> smaller crashkernel size, such as 192MB.
>
> An alternative approach of reusing the existing rootflags parameter was
> considered. However, a new, dedicated rootfsflags parameter was chosen
> to avoid altering the current behavior of rootflags (which applies to
> the final root filesystem) and to prevent any potential regressions.
>
> Also add documentation for the new kernel parameter "rootfsflags"
>
> This approach is inspired by prior discussions and patches on the topic.
> Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> Ref: https://landley.net/notes-2015.html#01-01-2015
> Ref: https://lkml.org/lkml/2021/6/29/783
> Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-init=
ramfs.html#what-is-rootfs
>
> Signed-off-by: Lichen Liu <lichliu@redhat.com>
> Tested-by: Rob Landley <rob@landley.net>
> ---
> Changes in v2:
>   - Add documentation for the new kernel parameter.
>
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  fs/namespace.c                                  | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index fb8752b42ec8..0c00f651d431 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6220,6 +6220,9 @@
>
>         rootflags=3D      [KNL] Set root filesystem mount option string
>
> +       rootfsflags=3D    [KNL] Set initial root filesystem mount option =
string
> +                       (e.g. tmpfs for initramfs)
> +
>         rootfstype=3D     [KNL] Set root filesystem type
>
>         rootwait        [KNL] Wait (indefinitely) for root device to show=
 up.
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 8f1000f9f3df..e484c26d5e3f 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
>  }
>  __setup("mphash_entries=3D", set_mphash_entries);
>
> +static char * __initdata rootfs_flags;
> +static int __init rootfs_flags_setup(char *str)
> +{
> +       rootfs_flags =3D str;
> +       return 1;
> +}
> +
> +__setup("rootfsflags=3D", rootfs_flags_setup);
> +
>  static u64 event;
>  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
>  static DEFINE_IDA(mnt_group_ida);
> @@ -5677,7 +5686,7 @@ static void __init init_mount_tree(void)
>         struct mnt_namespace *ns;
>         struct path root;
>
> -       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> +       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags=
);
>         if (IS_ERR(mnt))
>                 panic("Can't create rootfs");
>
> --
> 2.47.0
>


