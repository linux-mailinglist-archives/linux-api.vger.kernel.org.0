Return-Path: <linux-api+bounces-6833-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vu/ZORnxU2pcgQMAu9opvQ
	(envelope-from <linux-api+bounces-6833-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 12 Jul 2026 21:55:05 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A001745CAE
	for <lists+linux-api@lfdr.de>; Sun, 12 Jul 2026 21:55:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=google header.b=SQkn6FNz;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6833-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6833-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7912300C5B8
	for <lists+linux-api@lfdr.de>; Sun, 12 Jul 2026 19:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990313B2FD8;
	Sun, 12 Jul 2026 19:54:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63D364E98
	for <linux-api@vger.kernel.org>; Sun, 12 Jul 2026 19:54:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783886098; cv=none; b=nzQad6+CViC6XZRAth4AWoU/vg4r8LpP2IRjY1cCOcLJBl6SbZiwuwaghmhKi+eErU/WEroJwZ0UfP99tSNTUXxENFMkUxXGnkE7ReZ0htefH7tTaGrF0+1ZGMqu2VgK3R/mGqAauZy3MAaKZxRRZ3tb5Lnh+qelgg8nN6cFubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783886098; c=relaxed/simple;
	bh=1kvan+vx5y4l8LFStCU5oqy8mYYDYnYZjGgPGVifyYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gl1bes4+ZDMy5pe4mcpS+gPrvj2hFu9ylAe4TaytRMhhEdIddLwrXuO1LfKYJjuiIyxgZ7zBBiLYeWGegM4iVvMI10w1Wx72rpIAb4Ria6ZpGO2uGZcfFxBkZ9Mok3Jh33BoHShd6GHZI6dJTV3Jskz9pMO+vxJUE65JyXh8Xr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQkn6FNz; arc=none smtp.client-ip=209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15ec1da77aso285482166b.2
        for <linux-api@vger.kernel.org>; Sun, 12 Jul 2026 12:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1783886095; x=1784490895; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0VV9UQ3tklAc3FhQMVhQNd2mzbWD93fBONoSN0BdPw=;
        b=SQkn6FNz0PzG6V6Ax010QIPn8GsI77CQ/MNqa7eMqKUmTWKTQXkaxQV2dQKcwlrlnY
         0kNYAHDRi9q0nd7vBjlOMjJqkX7QU4fQ0s+MvTDnNb2MRWIA+O7p6Gom7fLjeR85LnOa
         HYamlMSvtpim9OcxWB+UhUVZIQWxom8MUmDDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783886095; x=1784490895;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F0VV9UQ3tklAc3FhQMVhQNd2mzbWD93fBONoSN0BdPw=;
        b=c/Etj55WfXCrX1oRPfxPOxunGUWu+S/Tr3HDzGmit0s/fMee1HdV5onqRFAlx/MDj1
         Gq+dkjB/3Bzvl7xE3My9hxB1NW37HhsoUTZCdHDADEKDe46ICCvNqHEDjEeCo9mGDoYx
         Qxqrdjq1nZvMhPdLD1gS6pcEu0CKYdmWzKJzpS9z9MyLyVg7vgrq5I1FkNUz/DrYHY3e
         MorXLuvCHIT8C3ZIygeKJWbhRbI2vIpKEeIHpxOvRQQerDUuDfschCKwMp0p+q+x3jOO
         zI9YZvlRH6c3CoS/T8uODn3LJjA7//oRgYnq0x84/ja62wKwhwNZJ3V5QhlEOmTgVO0Y
         TaCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjpHV345fL3BcSWRLrtEoc50Y/387/SGz8jDnk/kN3tMH+rVsSHSQanzlhVh45Pf5mFbJv6Vturq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrf3qUqcVHmZSi8EExUSk2NWhI52hEDrafpTgpoydRun9d2GYw
	N9yP3Rh1tLmyimKIiQWG1cjGFsGgp/MmaZJ2/KSEHL3fROnj8bNZwyvfi8vDWFkcYukzYFwourp
	8U5+E/qM=
X-Gm-Gg: AfdE7cn+Pjry7UsIQBxSoV5Kco0maTo2aiBV8jhjf0fNFj3Sxy5j9Yi/RfrLJg354K+
	itNZXc80jbKdzzvjuInLRU1XIpDoF+K/A15DrVM28Ie4RrwozQoD/fYNxqAtXhQee7v871HNaXF
	RXk+XMMJJo3xeTFyL0V2Reyc+Nt95jujrjhCDa+mfGzmWY5ugRqQehIn1iAgdFzXoqE0/NmQoty
	bVKabxRa4pK3I4t6eWRXD0ko3LFlmG/4J9IA3JLnBRNZ5MmGG0iyh0p6lnvZx30CHBwGrppXirQ
	ideSYlrbVy5zj7POvqUHH/ur98X1urMxVoRfr/7P6GoB8nQpSZz/6KuUDgse5I3bK3/a+SlR0qr
	g9xBJvKD9eJEPM6gFxUuW4IyqG1TDmrgambTEzmZgPxjhJ6eZ8RG8cvO9dwntsLyCybGpkJn72l
	ZQCqtZiwIYBx2efvdNQdUIRhQb2BTLMO9nZRzBZTtcJ3OCg+dS1OPJIdkEs6Pn
X-Received: by 2002:a05:6938:a08d:10b0:c15:cd54:e026 with SMTP id a640c23a62f3a-c161e9db949mr168015266b.31.1783886095226;
        Sun, 12 Jul 2026 12:54:55 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad844cacsm910375366b.19.2026.07.12.12.54.54
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 12:54:54 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69c19a37eeaso4870227a12.2
        for <linux-api@vger.kernel.org>; Sun, 12 Jul 2026 12:54:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq1ZFz5PL4TkdRg56CQ+bkSC94A889SA0IUpEtDpLn1u2AxpQwgsOV3HJNlOt5Z2zyz0RQ3InEjSc0=@vger.kernel.org
X-Received: by 2002:a17:907:70c:b0:c15:f69f:a175 with SMTP id
 a640c23a62f3a-c161f3aa55emr277371466b.62.1783886094122; Sun, 12 Jul 2026
 12:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi8aXM9=Y8othMb1oxTv-PDw4isj-FPbXu0MXsm_EPE1g@mail.gmail.com>
 <20260712171147.323213-1-yong010301@gmail.com>
In-Reply-To: <20260712171147.323213-1-yong010301@gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 12 Jul 2026 12:54:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnwJc_QRQ6x_xLrtuUj8ia=6z6-RqeoQe=QCycwKb=LA@mail.gmail.com>
X-Gm-Features: AUfX_mxIqp9BwQni7oj2xhhxFUZUBEIrvb6hAsoVFk8o0ynLMjoMzW6T3IceRHQ
Message-ID: <CAHk-=wgnwJc_QRQ6x_xLrtuUj8ia=6z6-RqeoQe=QCycwKb=LA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Make the TPM character devices non-seekable
To: Jaewon Yang <yong010301@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	security@kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6833-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yong010301@gmail.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:jgg@ziepe.ca,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:security@kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[torvalds@linuxfoundation.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linuxfoundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A001745CAE

On Sun, 12 Jul 2026 at 10:12, Jaewon Yang <yong010301@gmail.com> wrote:
>
> Call nonseekable_open() from both open handlers.

Ack, this seems to be the simplest approach. I'll just commit it as-is,

                 Linus

