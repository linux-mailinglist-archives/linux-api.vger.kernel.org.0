Return-Path: <linux-api+bounces-6793-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /n5mIx9bTmrWLAIAu9opvQ
	(envelope-from <linux-api+bounces-6793-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 16:13:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7E7272E2
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 16:13:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=ZwbGkLuY;
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6793-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6793-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E56653019FF7
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF2543F4DA;
	Wed,  8 Jul 2026 14:09:09 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFB43637A
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 14:09:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519749; cv=pass; b=N0b+yF+bKoJrJdB3m01FveMcLYtCR9L7XSRnhAxtyLtsrPqoeZiT3MyrQNaOpc8Tw2Ek7nnViAz5LKNm9PrX0n6GPXCJOcHO5JDBD1w2pNlNkFK4iaj7CF0YXKqEj/W+98is4RDuugcNIAtWC/S9Brwg+vD7QdPg6IH974Iv2cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519749; c=relaxed/simple;
	bh=GiebgX43JHl1XQjvBe1+RPmR9h/Aa96mgIB3IChL5tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofxVHAZRZWjZVFGKxoedRtUPXZUxsdQHeXHhMBqMBfhF1Zr9BhHIgZytPLH/CUpjLStatZTQPYTMh4kqk1C1o0pddjzzuP9o3bT0nO4vNnLGv21iDl8KFtOAkgzlZl4x3jfdljSTPvBehyRI7ugf1maNZIQcSnJzV/V2mYjLqOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZwbGkLuY; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c149c5722so5386591cf.0
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2026 07:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783519747; cv=none;
        d=google.com; s=arc-20260327;
        b=XnQDI59m3JfxnX5uWC78vaJ1vBkBzq+7AkINDgxNXh5sLHhRmaEEjgN1XuTGjwNl79
         CjLuaAP9kduK9mJnAXkg5uXulsBfeHcT5WfmnhxUwXZ2Pnkst37aDP97kkqktIXt5+xB
         c7oDEZPD8RFzSW3a/8+hnskw04PfCnPm8lE6B7zHP4wz74mUygM+WLEZXAfrCNS5g/XL
         d1rA/eaOjhj6cSyP1p6noZFghb+DqOV2z02vkrooO3dptSUM+kL+/Gl7Jeo7W6TCeJTt
         5z3olbYtaT0/7Hlb0xuuDTeLhUxNreWYqRSEmZUmsTouRT0qGZQd3DVQ57tj13wznUJb
         B3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z+GhnGa9iy5ZTH9B//oC3EDENHUg5DrCxZ+5xNsaoQU=;
        fh=6LaG53rl19Wy4mgfds3yeTB/JAzpT86AmOMdcAjsUls=;
        b=WmFWrN3PxWPnSau5EOvrCTXTw0opLAQuo16SvgfAjWt83mlhDXfEfVMSeoaFIBFSm2
         DRiIEZH54h1ADN2AzjrbYA/VhxLwI5hZBlLhyLPDXXarxSAI4upetn5oDoaCcX/1JSIF
         xBQEc2l0Z6p3shVJaM89dtc+DguzwIqllYrQZGDqC/ahePOE3M8aDTr4ZmqD8zPYmgjL
         IhTPj4mt1SLAXgBnXLzBxGVwjpzlQF0bvHrFXzpu8zTqIzofY7vq+trZ49WZOaobiF6v
         9p+sOeDn4vfwxBWtI1m9aWaOD4hNPhM8rRW1P/PNzMNwO5kt98+dPjgPWanHz4uh9Y8X
         h8sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783519747; x=1784124547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z+GhnGa9iy5ZTH9B//oC3EDENHUg5DrCxZ+5xNsaoQU=;
        b=ZwbGkLuYcoqnD7Vi14+foIn881NX4ewXtmq3IX9BBdVmbdn6EbI8uPwZfNFd4PN94n
         VqzBx8c9iheU9EwBLmbGMe4VN36UI8UWjaoh8XRP6qa2kzOE6daEQmsQZh5LqdwU7NUT
         B5e4pOrqGAZR9SLHpUnBW2aIkg+4GMFPh0MIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519747; x=1784124547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+GhnGa9iy5ZTH9B//oC3EDENHUg5DrCxZ+5xNsaoQU=;
        b=Eog8maV+vmf0QB2W+f4XifVuwr/iFp2Ys5i5tvqHnQoucyjjo4THhVyoTg1hxGoaSg
         ldWa0a/O0D6fDQtb1a7fKAyWaR0W+TxB2rUdYGVaCcB0ebNtjgZ0JUx7UekjAMutmXeo
         sMs5yysnvQ9hSnOFmgxPypUdDWA8tT9QJTA9vYsfNlj/+VyyDr2u3JITrn2Bytk+c9hk
         3qY/TZSJXDmCW/ePhXP4OGQ7IKlxCE3c75Mlje6BT8T5NG9zILt2KoM7pMhRd6LfoXmg
         pLPQ9y6NUo//88iHdEtoNSZitfOrKtuWOVLl0xPTI9IwgZPbWU2/hb9jRY/b0TmAp1mD
         gOcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rog41kyHILRcqzLuV2gIgArTt969RxsZWzN5B3fDUtL53COnexqlrAnQtNu+P2742e93mROMMdrElo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQqex5Gby8+/6uapxxQh/50qFRp+wQ1rFjzy6xs0TrVvFbwmH
	LaQ+umH4PJKDqfh8t+y1Q5bn/+jKMx/VYlm1aCIjcL9hXTLKQKCgfX+H1Qe0ItnmjMFQWInuGbt
	lOhZbBiFeu8S++UQoTD59Xob4U/N206jy6FC6dfAP9g==
X-Gm-Gg: AfdE7ck0qP39pU4AbszZBro2oZUWmI1S0L6OONGLmMOrvoOO+4fi3cBlQ3O1DP2n/b7
	RSqpM+AlBsA6w5mO8r2z8E+SoG+vrPwx/9MSJOLWDUdjgBSUKWEOsl9+ztJ/AOfUBmNTvxMPgsU
	67hmxDK/hgrTO2DfqlYdRedJI9VHj0yFVLUvC3+TASTAjPDQyhNMX0HDeH259mRogVN11q8dQV9
	ejAPtTw6y2IewZY1XWtobKBzhwVrYDLQXR3Quih4wZoZCUG96dPi6+uvswYQ4dZQQV9hzkNK6uZ
	Lynazi44wkk7m+k+NEsXORaTGBN5Y08fdL2vyg==
X-Received: by 2002:a05:622a:3c9:b0:51c:f8f:13b with SMTP id
 d75a77b69052e-51c7a7516b0mr72139411cf.23.1783519747404; Wed, 08 Jul 2026
 07:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com>
In-Reply-To: <878q7l8y4y.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 16:08:56 +0200
X-Gm-Features: AVVi8Cct3OYBryqlcikbWlWdxAzz_Gr4yKGpmk-iVfq-KrBGvr4PWPMuDYrvjcY
Message-ID: <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6793-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BE7E7272E2

On Wed, 8 Jul 2026 at 14:27, Giuseppe Scrivano <gscrivan@redhat.com> wrote:

> is there any existing user of such a mechanism?  I don't see any mount
> specific info under /proc or /sys.

Not yet, but I think it would be good to have one.  It's definitely a
bigger bite than adding an ioctl(), though.

> >> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
> >>                         with numlower, numlowerdata, and has_upper.
> >
> > Isn't this info obtainable via statmount(2) already?  If not, it
> > should be there, instead of a specialized ioctl.
>

> no that is not exposed by statmount

I mean, you should be able to get that info by counting the lowerdir+,
datadir+ and upperdir options, no?

Thanks,
Miklos

