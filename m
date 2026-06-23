Return-Path: <linux-api+bounces-6647-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tJ2pBBDXOmo1IQgAu9opvQ
	(envelope-from <linux-api+bounces-6647-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 20:57:20 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA36B98D2
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 20:57:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=P1rC2xKg;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6647-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6647-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27265306FC21
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E873769ED;
	Tue, 23 Jun 2026 18:56:30 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F282C08BC
	for <linux-api@vger.kernel.org>; Tue, 23 Jun 2026 18:56:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240990; cv=none; b=sV2tY+ovzCRfv7iUtU2ohBTW/hGg60jGHmslvYn7PPy2yI7uiW3E77291HG/N55bjJvphmO7IoROMYQZrQSBDzeFzb/DCowAD48XwrOD9OGjlemaa3xzuWqE/IlqcVJ5/rAv2bFH3Lyid1r/fx3B4y905/VSDpjPb3kMA50SSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240990; c=relaxed/simple;
	bh=24Dn8UqRZ1p8BQICezHYOo9NJl5h5GUSnVLscYJARrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqkN1iMxkck/PLPAr16MgnmPFH6NI5iu0Lr10jWJHwA026CFvZ2JYBdRiSuolbiw5sVLb0r0wfnDhqRKsN3qIHdJrVhnSUzCz8liwJMV7Hn6tgdzOXCuU0dbhgoFJeRIigDtIE3Mc6mV4Ir8zhHv1CszBdqbNN3iZPPNrCkXk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P1rC2xKg; arc=none smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c029505b389so230353466b.1
        for <linux-api@vger.kernel.org>; Tue, 23 Jun 2026 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1782240988; x=1782845788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTYMiI8T7qy3LqZCJa3jMkJNbrBL8JjUNCpZXVETjNU=;
        b=P1rC2xKgIfv1C7HAeG67IQX0uA11r56+jg95zHeion9XESiVGv9pzhlHQE8vXMGeJQ
         mEubM7UVwMu3Etn9+tV+WLABv9ZMlbo5KxxsJPEmVjg+zMmV/rtCa4UgUC0Iav8WO7vk
         ssw17MJZXFxwE/rBj46DKsZdD32Ahj1P0jVN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240988; x=1782845788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTYMiI8T7qy3LqZCJa3jMkJNbrBL8JjUNCpZXVETjNU=;
        b=c6sckF0VOvOzr4kUwYEtEc/PUGSQdpZtWzjhYm+MQ0BwXlraxE96S37WJzf2N7vlBo
         l9OUbAVdom8OuD1bh+KReuvi9BwVQsCO4svWQ7FKwD6eTvxNPyu6pZFYWd35EFoK8jna
         TSv+YOC7EB94ZRvGoGSXROO8T80VJVBSDBABY9Gsk5cI76gx9m5dmLuiTlnXIU54rsSg
         o3CgXP2Uy0edB/1evJrGF11cmDEDYhiGYoUfA9a+Q66radJwcf9w6aJtkc/DxZ9EEszE
         1LXVB27xJigpW0ChjDCFSsp5zoQLShtEaTCT6TliBsE15/+R5v/VCTFC7dUbLVNnfWO9
         rRCg==
X-Forwarded-Encrypted: i=1; AFNElJ/qVkJFlmnTmVUTYI2tRkfdjRiznXWGaoqHEvrHG5ctx8UAfhp2hCGoMZgIC5hgfvEx7rcwnIT6XmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbs5KwseTnioBMRutfRXO5UlhT9UU9xCKs05WNB41l3EQ6Tsk
	oVusgZzvwe34sUm89H2QE5iu+bfq9xjuG6anqPURxAS2fU/zmB5m3b3rEmKUCbePRPKirrv+d5D
	qcKSPTIc=
X-Gm-Gg: AfdE7cmi46OeJgRXrNXfrD4cg2FKO1U4BAE5vt9r+jJ2PAojgeeoxzjXGGCELagk1WP
	JanRFjOLhoV50IfISygvYwBopCRwjK0QC0eLY0082jVaPHryzp4ZoCl9SDtdoFfs+bPc2Rx2UE6
	EIelEh2FrcC4niUHdkFDC+hQMUe+Pr4LZkLOwWPIS0ji786lLVXelkUbMeqRyeweBVxId3oAdIN
	uKqhGhBmKGwnlAT2p8yD6i73s3H7cyHZQmVdX2p5oTUSuzB5vVlKePhrkROQ2nnkiWnghHIJhVX
	PzoVL9wSJsUPvZfeoQSZ1ognZ4q6SchnQtaT2eoea54NMOdzaudVabl7sSpOH7VaXc0ftD7x8HB
	Ss67b6jxWAWkCL4pqC1OwirIaFtwz+2N+N5/2ylyt4HBHyZJbqir4GFqc6nTuh4dvZc+PQSFVmj
	fHeKoHf2Z+ZHFP7s30RLzexktGUalWICFXZ7seboDMe2heXraikQ0etq6DGg19UWsyLypR8y0G
X-Received: by 2002:a17:907:3f0d:b0:bfe:ed35:e854 with SMTP id a640c23a62f3a-c1031d5d92fmr170071766b.25.1782240987907;
        Tue, 23 Jun 2026 11:56:27 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c610e526asm550956966b.51.2026.06.23.11.56.26
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 11:56:27 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c029505b389so230349566b.1
        for <linux-api@vger.kernel.org>; Tue, 23 Jun 2026 11:56:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+a0zLUXpkikXAh7a+BTftdtMI+sEy+zfRxYf4VN/bTgxlWKhOk/SCshDT98ZqAwkp3r/WemD6Uyyw=@vger.kernel.org
X-Received: by 2002:a17:907:c207:b0:c11:8357:40f with SMTP id
 a640c23a62f3a-c11835704bfmr15229166b.2.1782240986490; Tue, 23 Jun 2026
 11:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430011544.31823-1-ebiggers@kernel.org> <7d08a6df54279e9915f5df6bd4e5e5dde52b4fe1.camel@hadess.net>
 <20260623164932.GA1793@sol>
In-Reply-To: <20260623164932.GA1793@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jun 2026 11:56:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNG=F3xO9PjL0RcKy3UWvq0Np9uZu+nFUQBAA8So9xdA@mail.gmail.com>
X-Gm-Features: AVVi8CdpFGqem5dP7mBI1VIDKVc8WIWTZWMdjSeug8fejnSzLkFpq4QaapJhuLo
Message-ID: <CAHk-=wgNG=F3xO9PjL0RcKy3UWvq0Np9uZu+nFUQBAA8So9xdA@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-crypto@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, ell@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6647-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:hadess@hadess.net,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-doc@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:ell@lists.linux.dev,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[hadess.net,vger.kernel.org,gondor.apana.org.au,holtmann.org,gmail.com,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:from_mime,vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FFA36B98D2

On Tue, 23 Jun 2026 at 09:51, Eric Biggers <ebiggers@kernel.org> wrote:
>
> We're aware of that and are taking it into account in the allowlist:

Note that if we can  just unconditionally make it depend on
CAP_NET_ADMIN, that would be good - independently of any allowlist.

Because if iwd and abluetoothd are the main two users, and both of
those already require CAP_NET_ADMIN anyway...

                Linus

