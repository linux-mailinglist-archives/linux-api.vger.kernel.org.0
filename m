Return-Path: <linux-api+bounces-6622-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sk93OXpZMmq0ywUAu9opvQ
	(envelope-from <linux-api+bounces-6622-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2026 10:23:22 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400069782F
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2026 10:23:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=rMi0iNIN;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6622-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6622-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 060CD3012C59
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2026 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F2E389108;
	Wed, 17 Jun 2026 08:22:41 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54F38A71E
	for <linux-api@vger.kernel.org>; Wed, 17 Jun 2026 08:22:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684560; cv=pass; b=nuekJuEkmqQjiTn+rVpLE1OM8KOONc8qx+tt4/M5CDGNe0fEn6TGbOFh8dlB9cGwFL/0zYXsBMRHCC1c86JBH44j0bC2kfeUTO8AUtoXQMt1pORk/DB516NLDq9S0eB4N2gYp2BxZfIyz3L0zuIXCD2pp6zdeoBpdpzFCO27Vkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684560; c=relaxed/simple;
	bh=xvOTAcL/OEi1dP4MlZ52ki7wL7tL1sQQL7OUhgqBmNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RR39UkoWxeVVbXw+s7ng03zH7fEmy9TDaagA1Hhofs041vXQTadniebcKm7to5P5VmCzuksoX97xgxqBCw94JNy+0DCpGQKkUIsbMPbuXwXmArf+i2DOxJHKaVnAwsMWpxIvIXyzZmJvhrHr4U+QiQOX2xunJeXr6wOSEkLG+wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rMi0iNIN; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5177b9a02bdso73407271cf.1
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2026 01:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781684556; cv=none;
        d=google.com; s=arc-20240605;
        b=Tt3LopaGVyNZ+1zo3RkP56sTn+Z4AQ6lPSafBYiR1XE+j44mMDi2/VZimEI78l4u7j
         QIEpAdBXUqBJH0XuwJkobkHUvh5UG4mMf4eP5q3gJaSbEsXbNsoAlVN0z3JLMk1VLZSR
         3yv6FSsmWrDfs+ixzRc38ftojQvRpL1kyOXtDnEa26azoZlopnBry1sgJnHYhqVIGt/s
         tIaWWGZ+98vERu/s7Sv10RdEKOv3DI9KfhKqgGW8k8K7z6EoKlowSB8KJKa/iVkLtz67
         tYC3lmgiMzGUp4VUpmpwsPS3WtH1+6s4o7bRUz5rdN0XOo+MM2j6SCeDEOQkn4mx44/G
         OXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BU5fXnVq2Oqd0AAAN7spvlRTj86TwPYYP6Lo343Jbco=;
        fh=A+40veVBWQ3WZEzlWwajkzuRL2J3IVLr3UBg2isUjtM=;
        b=FDI5HDygmMZVQhfQTVd0nEOAO5DCNJx5O2d0kZi4rPQBh1qFnOLrF6HtDi1AEDLndj
         /EvYi8ktz/+Ove5oNRLizMphjUJeZsXFTSKeWbwYfndOOFfUEEs6JRnFFIEJypJaPbHT
         LPswFY2M86ER3NB1jBDdbjbc7AuYtdu72+AhI5MxxJm1t0tB5pYhJqcqFJyl5vWjYRZZ
         yUIfLSMI9ZaKtW9AvHAjnSSFWpzmN9HimjD8rsIZNFS45vG/okWNuNibI204ieE+hdOg
         T+ayFsJ4BipILTljFN4ILQE73WhKGRVsDvl9f1YSA2O1KQD+1NxXOL4H8dHwhuWUKZPl
         H4hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781684556; x=1782289356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BU5fXnVq2Oqd0AAAN7spvlRTj86TwPYYP6Lo343Jbco=;
        b=rMi0iNINHVIIU04xYxHAox8+KXWg3Km2fZo8UC0ogLSyCYukBp48Y2LATQmEzeKIZ3
         sOokLNQNeqIhVniNeFcxvWMePu7oQKia5baTHQFYKvoJEU7Ctxt3I7Kto5pqxNRT5bPU
         07LzofAiUvuU4B+PFpuYAOSrFfE219M22LYGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781684556; x=1782289356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU5fXnVq2Oqd0AAAN7spvlRTj86TwPYYP6Lo343Jbco=;
        b=JjS8ZK9+iIir0hhiI4Qoc4Ltup0anHAgOuAXkLHwB5/ReFgJkxcBLVvYrPDVQXVqZ2
         XlKd98INiZreGZRMbJLqa51MBj8qWlVrPa7eQKfgaQy55LWq+BY320JdK90flEMmDDmY
         VcnHhwnDM7/Bde30My6V7aZqjzz1GveMkXZw5SnZD3Db6omH/H3inVyhy/xg1Joyfvqg
         QqA+e1ilWVg7HHDhUV69Mb65u0JqYOKGSMKoxvpHrRuPZyrykFbb+Uv51jkV/8KAJ9/+
         IYc1KSX/XIR1XCgtfPCSscfMrLzW5PE5GvfnZSOXF8j2hyp2tSXNT/o31TkQ7tIzRFoD
         ugYA==
X-Forwarded-Encrypted: i=1; AFNElJ/QNI6utrPd2fvkeY1cmB88oAAjo1k7KBDOe75Cgh1lTrBN1vLtVvVOGLPTlplLIyDh3keE+TLfjGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziGbPT0tMAOH6ei0o7R3N+dVoCUK7MOOvX2u43FQ0ox7l6DMyl
	X9Gr30FfP1Y6rSzohty02d9vPYfqJ3y9grs26T9D0t5/s3h+l2EjqzUcFwD0k/ur49PGuR3beis
	XUbuWBtfeGZXQrmGNS26h9juno3+Vru3eZuC7PGI80uo6YEffaFkA
X-Gm-Gg: Acq92OGIeUAPyrKArkQQTUCOwcM7f91ujmPIOa2Ivrpi/3VyIKvgzG0DFBcOWVlU3aX
	fqXQw2HvYPW4JySwjgZlDPsyQ8riB3Ky6IPu/aXOL4uOeA2/oGdz8sUvmfbXllzzchi0qhkY00T
	Ii/ShJe+rk0w5Hm3YJBIUHuEu372MF7cw24vB24ezRBfX5oZMNYFwZohQSgzb86sMtuLGKguD0l
	tCN4zOSgGIMQwkRELgjiNK8rKmgC56b6i/zEwyQ/CexffngwfsHmYZo+PpvZrLy6VnFLXaFf1jg
	Mb5fyI7i7PtJIVR1M48znlyBzt4=
X-Received: by 2002:a05:622a:5516:b0:517:97f9:78f5 with SMTP id
 d75a77b69052e-519a8c6606emr50572071cf.10.1781684556219; Wed, 17 Jun 2026
 01:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616151909.916667-1-jamz@amazon.com> <20260616151909.916667-2-jamz@amazon.com>
In-Reply-To: <20260616151909.916667-2-jamz@amazon.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Jun 2026 10:22:24 +0200
X-Gm-Features: AVVi8CfLUvw9HEz1q1LlF1z_PcpL4rUpzyaGd12mSg8e3Xcq01aL572WH-arImg
Message-ID: <CAJfpeguaa4U6Tsxh5opeaLeYQQxP6MQsRMu_JATJwwgj=OBt3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: allow FUSE_SYNCFS for privileged userspace servers
To: Jimmy Zuber <jamz@amazon.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6622-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jamz@amazon.com,m:fuse-devel@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,szeredi.hu:dkim,szeredi.hu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4400069782F

On Tue, 16 Jun 2026 at 17:20, Jimmy Zuber <jamz@amazon.com> wrote:

> +/*
> + * A server can stall syncfs()/sync(), so only honor FUSE_HAS_SYNCFS for
> + * mounts owned by the initial user namespace, i.e. set up with host
> + * privilege (like virtiofs and fuseblk).
> + */
> +static bool fuse_syncfs_enable(struct fuse_conn *fc, u64 flags)
> +{
> +       return (flags & FUSE_HAS_SYNCFS) && fc->user_ns == &init_user_ns;
> +}

Sounds really easy to trick: start the server in the initial user ns,
then clone the mounter with a new user/mount namespace.   The
init_user_ns test will pass happily, since the server is running in
the initial namespace.

Thanks,
Miklos

