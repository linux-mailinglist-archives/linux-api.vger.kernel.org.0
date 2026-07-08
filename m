Return-Path: <linux-api+bounces-6785-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rGD0OC8nTmrTEAIAu9opvQ
	(envelope-from <linux-api+bounces-6785-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 12:32:15 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E637245A7
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 12:32:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=Mg3hHQdB;
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6785-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6785-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9279730738C5
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1A2399350;
	Wed,  8 Jul 2026 10:25:11 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD94340260
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 10:25:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506311; cv=pass; b=XvQ4A0ArKzWITW28XMrjOaKuUHOspg/sXPBqjllAIjeJtzTvK4pSqOQkpPxHNipjGeEVDLrDINVlkueiGhREbD9FbiqzNqQEdKsdvoGXXmC2bhiiAz+DJZhJz3hiu+wPA9vs6F6xLJoL3U4/IOliL7IAFQubW7gtZfpCWR9vcD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506311; c=relaxed/simple;
	bh=v2iptkwSmC7pfjv/tAPSoVfRUn3ZZPHoGdlB4QA7hqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXO6gvX1X0tLgOj/jULJ/TA6TTF6e4crelX8vIeYgwWcpqdOs6/gVVrrzb1SKRfqNKD3J/tgAQceKDJgdoh1i3NJ1hCGwn6htNJgyXqfA0sZkHQIVoOOm/Zt1G9pfxlooH6daIzSRwloW71AQZWHRO25dEqv0Y/1ewb3choge2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Mg3hHQdB; arc=pass smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0006ea8eso3555201cf.1
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2026 03:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783506308; cv=none;
        d=google.com; s=arc-20260327;
        b=ZpNWqyB0BH0Y8Abr9QRZsgGvLOi0eSJ2xPoPfkwALzwlacyHM2xEqWSUsXR97S0YY+
         +k9ckEOIzaT7aXfSd5oF+JjFSPjujZV/6uNGnwsLRaolAxbTxSBn1JKdQeXI47bPinDz
         ZX5MtazUI+s5LlgGWYI48kQjJ5Nh0X4og6lzOe18Ikd7XREUdUGZhrEFu5zsTYox95MM
         VXZaDWvK91pqlzY8e8Mjq6wLK/rpvbmJM4Mk3VNZzXuWZKYTdMWQlaTC2W3KqThKyGgY
         Shb7BDWw9O74j2GW6rTzvUNqbyQwxmhcKdIChe6IFjn/JLtIXfH/nzXSpFBFb/MxhQbo
         HctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yQ494GWLnZ57cIKhXAy1AeNd/Rccg66OrqluMTPjUdM=;
        fh=bHNpxJ9HE8Cy5hKSsMXEHpuzFteQ0WZ1JFTwjcjGEQw=;
        b=kjrf6veW4hLSQZIaZnfyUiD47FhjR4pCmcqN9sSWssyRZLtoT9w3Hc6rZ3D49o+SLJ
         1IqKf42dKlNZqJI30IuAo2JN083FLPqUyzm3U72H+fmBYk+WwwycmIeAU5aANYRBI8M0
         zflelm8GhS3IedvLFeYkmMzKG0Zz2M8xVSD9kNyRuVXp07iybAUP+sgiR5R4LOnN3hvJ
         sik9y2IvBRWnFM2bonXYE2hhgANsAvCmLujxF5WIl7ebA3ANFnMMiyIa+jb5TMb0pJvJ
         topmOEVdgmBC/UyD4uBcGqm9pnDk2uJZfouIyaI8GML4aHSfs0AGQo5C16MFq7+4XvUA
         APkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783506308; x=1784111108; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQ494GWLnZ57cIKhXAy1AeNd/Rccg66OrqluMTPjUdM=;
        b=Mg3hHQdBKffZVJhW6YLkcvGtjjXB91BMFTVl6H2iE5b/QH5Nbmgx3zo8BP4c3l7kM6
         SwmNstjdVPqU+3PweEYhncYDXK508yMmQiWHh8TaZ73FZsseRKxhoUBvVNr6tNaG3sox
         ympDg+MP7NgjdQpTjAu0GQw/nUN38fegAoPLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506308; x=1784111108;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yQ494GWLnZ57cIKhXAy1AeNd/Rccg66OrqluMTPjUdM=;
        b=jtoCirRzljjSkg6Q35TuA93pw6umg9QiM2hta2nHTlw/X65LxlSJIKkelfXPSDLQhW
         hr5LiNDsyU3uDbOxaxoTBE1zjGXD4JZEk2bGbQb3gykFFCCiFnFVc3qhamOro8MnGuom
         NMOhCZShsNExSA/YiVQPWGTLVxKXA7W7gGq9G0R/YdNpdI/VPGzIgtImk5xXOOTtzRAL
         JEbKRq50j34bUzcmMrFMUQ7iJDl0rnXrVihUQkvIoD8nMSY6EfnSlbP3yviV35mrSIP4
         cewlYL4pEoy7zLcOYD1Ovw4/owt5b/59OmrHKHWm/JhkMsCXt/6gHpEiYSMKb5wMpP81
         EmGw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8v3K9E/4ECLRBv+Ynw0UWOqhvA26m4/sruHbG0ATyK3478TkVPQDqaUjilyWECRp/RUFPY02nUhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfncrSA/ggbgEZ2NkfVtnvSHlNL8EiMV3mg+CfawC2XTQkx25/
	7XVLBY49iSTFbTiJt1FyssnhvrNQdIuJlmSRqZ89bKzp096znkU5diM++I18vUk3FoQbDxiK6zA
	YOlzQ4C/XdxtngjTLd/8MeJC7Jk1GjqMAQf6H3xQixg==
X-Gm-Gg: AfdE7cnGq1s9JNxwaK2nMajpIcw6IK8Flie4YE8bb+OuSua6DNC2jXpAsIX29DerGMb
	G5Uaxeyv41gDEsx7JaV56xzCZwC1Fg4auNuBw3n1HL6t+ZRGRwE8a7m3wLtE3Vk+/nOYG4PY++/
	BYCgHrMo98VauvLGxvpelEiSj52wWgMpjwJuiaJP+HUPLMoTE4MnfB5VFUxnaFu/MStMOFpTwJ/
	UPUHy+l0BjNwPBi6DRpNGUPiBlo+AEOdwb+bOTkp1rR4kWKMWtRVpLC6tHDOKmfWtKy1bIRc9vH
	aUHKloK91OXlCfz2YS1S4e8hpqQ=
X-Received: by 2002:a05:622a:2282:b0:51c:7b12:5fcd with SMTP id
 d75a77b69052e-51c8b40a23amr19083641cf.73.1783506308598; Wed, 08 Jul 2026
 03:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com>
In-Reply-To: <20260708095831.3381978-1-gscrivan@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 12:24:56 +0200
X-Gm-Features: AVVi8CfCXklAzPR7aDHbzayp-qscildNngPjuk9ohznhtjXLzwjf1tF6bysoZxo
Message-ID: <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6785-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,szeredi.hu:from_mime,szeredi.hu:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47E637245A7

On Wed, 8 Jul 2026 at 12:00, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Add two ioctls to overlay filesystem to allow userspace to retrieve
> information about the overlay layers:
>
> OVL_IOC_OPEN_LAYER:     return an O_PATH fd to the root of a layer.
>                         arg == 0 returns the upper layer (-ENOENT if
>                         no upper is configured), arg >= 1 returns
>                         lower layers (-ENOENT if index is out of
>                         range).

We could do this with a plain open() call.  Something like the magic
symlinks we have under /proc/PID/fd/.   Question is where could these
live...

> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
>                         with numlower, numlowerdata, and has_upper.

Isn't this info obtainable via statmount(2) already?  If not, it
should be there, instead of a specialized ioctl.

> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -35,6 +35,8 @@ struct ovl_layer {
>         struct vfsmount *mnt;
>         /* Trap in ovl inode cache */
>         struct inode *trap;
> +       /* Keeps the original fsmount file alive for OVL_IOC_OPEN_LAYER */
> +       struct file *origin;

Don't need to keep the file open: the only info missing is the
original vfsmount, everything else is already there to reconstruct the
file.

Thanks,
Miklos

