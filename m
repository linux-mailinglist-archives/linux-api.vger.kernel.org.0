Return-Path: <linux-api+bounces-6805-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mjBvBps7T2o4cgIAu9opvQ
	(envelope-from <linux-api+bounces-6805-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 08:11:39 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DDD72D000
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 08:11:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=NFAqoqmz;
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6805-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6805-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F2D93024A00
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 06:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D5C3AFD01;
	Thu,  9 Jul 2026 06:11:33 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364793AF670
	for <linux-api@vger.kernel.org>; Thu,  9 Jul 2026 06:11:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577493; cv=pass; b=u2rfsLinIZLG6bb4hnAcTONFNklSe6efwWlkVJ+STTmQ+yy+kUowgjPybeP9Rci6YM7E18sCzF4iAJzuMN4ga1Mtq2LGYLi0P0GWVasbSEnvqfZUtYnxecB4p6phzXY8NS7XTuff5vOsBeeDGIZUcWL0yaSklIW/yebG12KZPZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577493; c=relaxed/simple;
	bh=9b1pHcb4tDFl3SXA5D25rB9XkxaOPF8WHE8yxdA4mAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sg+MWjAtGTN+ib9+w+qD8uSeN8WHql1c9gIb+UciOV3JHyBk6tCJFGH1kpWnrB/WybhIwqptvFsaUolxDr67KILq3A+EhpevrcGOKzyhOsFADxoPurPVP/kCbbu1AtcP4Tg34LAXjZcSknNtctqMAXTHfxiDjScZxFeVQ6ztR+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NFAqoqmz; arc=pass smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c15bf5000so7008491cf.3
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2026 23:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783577490; cv=none;
        d=google.com; s=arc-20260327;
        b=dDMaiZntPbk6kkQn6E+FB4kT1k0XMkw0h/6HDoe+p2wXY+6s/y1UFcQ+yJF017BqFp
         l0bhgOmcwtSLIAoMllXmwbUVZdLWwLDqvFCT5UwFga2wQgiSC447QSoAi/tEX+zF/m24
         lAx1eFYE/ePhd4kVt/fbIpROraq7hnH8WCFcjhiuRO7MyIoghZIxVH9TeM6inhB4vWmA
         ccYjJwdQ95lFAcrPke//0xyoEyEKeNC5XUOGDdyhSoFxc+RS51eKkxCWxHfnLgCOiqjE
         Oo/L2bW4IFuETaj4d+qz9rHycwaVwaZvlnN8qR48CGVeVg6miw6MKkR7OcD6rD/9Abhq
         Ehiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dQTwiRoPjnPhFOLmv3RgpTRjzP1fhVs+pKfZMaiYyTw=;
        fh=RUYRg62HRhPSMUmSJc04avY+gd7dX3tRAUAGeNt2fbk=;
        b=eziZJheKS0LS0LTqj1PG1gmFNXWFxaHDRv8hVHLPxKFeGs/X4v0Ig9Uv5vmc7DZYvn
         gvh6LrPCdCwIp3CEL5I6KB/+DRnL2grrJrVry+1VGft+ZvLDpc+o4mFc7/2t0U4OPww7
         lh/TaqyFnIrSNxHFe8hMePeKdderDjnPvCNyy/dbHzg/RIklbBcG4hNmAe/SjGqgJkNU
         e98nF24hbCT1PLjIBabiWF9B7zVgE5plUi/FT2ng8y8nxCsbqdT6MzOQOCql29v7rod0
         fXteY84SOp/A90eFXjUg4I5Z6IajgFpiSO03cl3QvsCWIn4zZonRjkRoD1SmXxa78YFn
         zjsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783577490; x=1784182290; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dQTwiRoPjnPhFOLmv3RgpTRjzP1fhVs+pKfZMaiYyTw=;
        b=NFAqoqmzRE+v4seoIqH9pEOna0l9VfjuaIKSQx/vXdYmNcQjtGl9v5loyKJWQtQjOg
         YI9YzoSz6bD7CRsfmfRXInTQ9QcnPVcbUGLg0/1eJ/zdUm7vHyrHNTglOBqZo36HrWUk
         orSqDqWGcruhNcI0qT2gS+OzJRTG33wCbHxy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577490; x=1784182290;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dQTwiRoPjnPhFOLmv3RgpTRjzP1fhVs+pKfZMaiYyTw=;
        b=e/OIsnqg++yf2CNhUq/pvjVofq4jYjPmTvQXZYU92jr33pV8DC0jOZlsrRHVYAoLxD
         YKlaxRraP0XcUNTTLg7ySlCV9YThYijZRBSWvSJppON0MWyFl0WrxB1gCI88l5TOHoLl
         fAhvtRrPkfKVyj7SqE+d31w7854iCJcVdu/tJYKlDmpUQrKLf20eZI32HulYZLkpSrX8
         tM/876Ld6SwqoX3NCEFs7Gy2zk7IjtJscyivchpaTPcaQ8y5QzZ5ZY0hJJkkSF+6KRP9
         SPXUp+dB8NOhiIvp23FBpdiTxhMDNk5+b3OeKoqyjTRs5Ublfo4qVvNoHu5Yyx8Pmeqd
         3/HQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4psimKkcTvTxJs5IEkL5LYVTCnfIhYYOWNvaPDph22RxcMXLjN6tv0/78PCQLfFIwvD0+0ziN8w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyewfjBXam0dWjcPcqKUJnPKBCmwZB5UbxEiqc2pUicWpCtlVl7
	j/xfD63mhkGYSQGqiUdpBGaGwYU/zDNeWJouem0M1ol9Qgkr+V7D3IVwtFecGLh+SDpRdXyzwGN
	wdYySRsnpw5JA3Ih8jUi2KvDKUTKyTmA43V98fe0k8Q==
X-Gm-Gg: AfdE7clqyCi1rOkABhCk+D4SHevQxoD+Lp97pGfSXV1wknUG/+xBWEAQq4BSLiQyL97
	Pa19+wL85qd7csc6zwfJGEoiSBGJ4vEtP1dyQiaF+12Yf2znYPZus3zOhTdZV5ADBMbsMwwcRcG
	qmCCqyj9xQKZsIz0Zc0AZFE/0WMlPuktDzry5CMQs750LVA6DSoi7cspeDwJsWxAo6p8p7po5a4
	8A6sRrTl6yKgVoWBk85drxQLXMTIg3SiPyd2r6JoaeSedSU6hzAGpbsYAog6S5+P5DzWkOcPFso
	NzP7KV6BRbkpjrjymQHtk34bby4=
X-Received: by 2002:a05:622a:2cd:b0:51a:126c:c6d9 with SMTP id
 d75a77b69052e-51c8b431bf6mr60467911cf.26.1783577489970; Wed, 08 Jul 2026
 23:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com> <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com> <CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
 <87fr1t6wyt.fsf@redhat.com>
In-Reply-To: <87fr1t6wyt.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 Jul 2026 08:11:17 +0200
X-Gm-Features: AVVi8CcVEq2J0Va4XFUVsVlovcTwuzY96sGW-KM_Jfd0atcnoi0NWAC1g8xQ0Hc
Message-ID: <CAJfpeguPzVqm7JqJhe2CpfHMcAiETGT4_e84cFBEWESr5RpEGg@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6805-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:amir73il@gmail.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,zeniv.linux.org.uk,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,szeredi.hu:from_mime,szeredi.hu:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62DDD72D000

On Wed, 8 Jul 2026 at 22:35, Giuseppe Scrivano <gscrivan@redhat.com> wrote:

> Would you be OK with the ioctl as a solution that works today, and
> duplicate it when an alternative API materializes?

Let me have a go at the pseudo fs interface first.  I can probably do
a quick 'n dirty prototype within a couple of days and see what
reaction it gets...

Thanks,
Miklos

