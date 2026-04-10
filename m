Return-Path: <linux-api+bounces-6080-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DIZDLb02GlJkAgAu9opvQ
	(envelope-from <linux-api+bounces-6080-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 15:01:42 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 928FB3D7D24
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 15:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02A283023041
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BF9199EAD;
	Fri, 10 Apr 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NJElyQOs"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04DF191F98
	for <linux-api@vger.kernel.org>; Fri, 10 Apr 2026 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824731; cv=pass; b=cW43cG+vaOVNx/0HIIKYiTd8F2atSQ1wuCsbIQVIFsQQ/E89kBcEvwkJWsi7JjWDRL8npno+MdJd46afSQRcLRYDG16HW8yA4qgy8UsTPMqCb4SQZU0x6dVpEo/Jj774AEl+GbOP4JNACFNIMfuwwqVxhLNlNsiCH4R6+fHrLKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824731; c=relaxed/simple;
	bh=Ma/sRkYMCQuPVcijTxIdrQjwIXAGmQpv2IWcMkfcFDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBIqKhgeoNiSl97EkIVHv0z2ruSSwVExyn1yw1oPxQAT2JhYAzMHku1slRQYuPf70CbQSyv4NJyH1ICEb/2iSlX8rcRyDj1GtJolSRelQxMmxnfvUs4cNb3sKXQLGyUoRYJEdK0yAbIOdboksTEKjjJ4s/XTqb/130BzRaYg2k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NJElyQOs; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2c500750dso2018395e87.1
        for <linux-api@vger.kernel.org>; Fri, 10 Apr 2026 05:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775824728; cv=none;
        d=google.com; s=arc-20240605;
        b=MkNkpjo54kCsT64Cm/0SxCn+pyl6KL+767fy6IiKArqrYAkoxFRnaBZT6qaTD0ubwo
         kq150yANnW/4pYM8MeB87RHrMbWkQHjo/Z005a9vE8SSqNg99z2CO4HuyGLxdn8wnel+
         y3nSXcvIAEJvhIzC8SNyTZCd0qoB9GQxwma1MUjLJ+nA55wwrwmdd2EgPYyAX2lFUzZh
         /wlj2LS/e8Xsr4KuLe6ZQh+1l2oBHJAL1moRNQtI0q8w0Xq7C0OBRpj4jmbHkmXTYPCY
         vVMPrg0wq6JCJBHW5wWO6tHq5NAiRbmr1R6AEUeR9axndx9fWrb9dX7RR6x7Q7OFMuGf
         tCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jp6ir6SF08r4VbOW09sDO2S2CoJm0n8b8BiisX6ozuk=;
        fh=FFGoS4kxg1KXjzumKa2uBREVVoiHEICNRY1Iw+NBMZ8=;
        b=jSoAd6or+YpW7eIIY0e9p/fxQSVRM7RhPiDFRNVskV+LlUmHeOrNwbP9yPcUrGZJOe
         ay+F8TwM4gtOP30zXc0fFCQdVhLgvtJOEIClFDGHVOP/ulw6jrtKuv341EvZl5GRXoLn
         jRgjwpjqVQJTA2kBpusdh4jj5LSrmYmxO+QTE3GG0lU5ZjZD4hk7i6okkIrzkbNjvtWG
         H2ihMLwQ/ZYzVku2nlhSbJ9UtNXwLxwTQ/JW3GvicCYKVP2s5Yt+fXr7mV9gInRVTwiB
         adfhWG0dj/oxpdmbd5ko5gfvGIMKrJMZDc8wNDvux1nvkOB+adD2LAQ5XSQN95GzMKH8
         IaZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775824728; x=1776429528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp6ir6SF08r4VbOW09sDO2S2CoJm0n8b8BiisX6ozuk=;
        b=NJElyQOsaI/JI3diZf5R2iDvzpHO5Rno/6PrURRFC2ciuTRhm9bOZcJNGBBpAw0k9M
         d0eAumjYDMwleKrFL5sdxcKgXso+cjNXLUSwynZgThWpXyzZPv++49Fm5czUYXeEyDc9
         LvMNr7zF0R7zzNzyGUJai9KFHcd9a8Bt5UsIX/J8VjT9MY1+dFq0G6SAuujGfs262rva
         YRixW4hEowNOvOtduXI8J5ir94hV5OtsEWvdtl3J9Adn5eFhqzSf3/FP4hQCi78572gz
         j5s4CJS0tvrS5Rqj1uyzbE8obUTA2+GzmrvjV3gWlgdhgGbXOyxdD01sBpvqOl89TguQ
         cuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775824728; x=1776429528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jp6ir6SF08r4VbOW09sDO2S2CoJm0n8b8BiisX6ozuk=;
        b=dBV00InUet785qZqRUTOu3bv/6E76lrMLKE66T/LKV6lbwXga4ysLm9D8a0S9HU932
         +JeVpElKB74HjU1Gsu6bsjY4mcLupJCDL6DA/hMrTwuZGFxxImv6LZhXaqgHUhWuolei
         zvdEyUCoi00+M5D3xj3dz/+W4noxLBKBcUKv2jEDbqYhpL4h0HSNl8qg+CN4vj17hw+W
         TgzvrNFytEK8xlKZNhqcl6OS11zWjzZQgAOq8Mq8R2uc0ARgFt47tQBQyJ4vXdVU5rpT
         WMQBXaHLS9a62x47zsMIZvgD5885+v40mpDCDZsHq7U7FRpj+SKLLuZ2+6+2nbcJ80BI
         TsKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIFQqLeSAyXyLhNTvPnj50Aw4s1+ae+a0dzSIYa6kLhIzfwntdJJ7I7czmI0+F+7J5OTq5ZUfj5oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBHSFNLFM+AXG0ayAfNBiwsdh4hWOOhHTDCqPDa5MjzSWQ2OD
	3NCvRG2Ajt2Bo2BmUMAX3X84uonEzmbN3Gfzpr8PluCgXGO1yyW904C59FJqc2jfmDaA0cl4zSz
	nnUqqBlPNKUC0AFyiUcqT2Ro5enpD/5PCweFiC1M5DkNtHOHdoos7HE0=
X-Gm-Gg: AeBDiesfJFf5mXGdGZSqdpOGCAJysSumWMsFUB4x/2+W4bHwVJa4L/i1eMBMUN3RFXv
	GDhwD57JQNjxQg7rANwrRcu/IxKyM6rUa2YSQKNoYMZjot0HjWpxKnFp2k6bhy98bT9/lggzfmh
	SAQyJyjd5BViv2JXTSqeGewoChUO7BJ2tOUDrDIkf5/v1UkweaFAHS2MEwxpQBPB5ffHXDNh8gC
	QaCckDZ26mjdLk8zv5QHR+wpB29JG2cret3UhpZTLQ9nNx5fD0MfWEOKbYcllBQsqeiji61yGOn
	oe1S+8jAzJyFNMn+9gWx37H2PEUrP0S1aPry+w==
X-Received: by 2002:a05:6512:3a90:b0:5a2:beb2:d440 with SMTP id
 2adb3069b0e04-5a3efb2c661mr1403576e87.22.1775824727838; Fri, 10 Apr 2026
 05:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com> <87cy175zrg.fsf@mid.deneb.enyo.de>
In-Reply-To: <87cy175zrg.fsf@mid.deneb.enyo.de>
From: Thorsten Kukuk <kukuk@suse.com>
Date: Fri, 10 Apr 2026 14:38:36 +0200
X-Gm-Features: AQROBzChuygi8NVuGrVHydrC2DeBgFvNeTy5s_fZlvJYC1uL0-6j2KTxJFfKvYw
Message-ID: <CABMvmLuyB1t2WJrDsFS8Jo0Mx19b3zZ-BA0Xe8JaCdJhouZ63w@mail.gmail.com>
Subject: Re: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Roman Bakshansky <bakshansky.lists@gmail.com>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org, 
	libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6080-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,sourceware.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kukuk@suse.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,enyo.de:email]
X-Rspamd-Queue-Id: 928FB3D7D24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 7:51=E2=80=AFPM Florian Weimer <fw@deneb.enyo.de> w=
rote:
>
> * Roman Bakshansky:
>
> > The full RFC, including preliminary database schemas and API drafts,
> > is available in the discussion repository:
> >
> >      https://github.com/bakshansky/linux-auth-logs
>
> I don't understand how SQLite (without a daemon) addresses the locking
> issue.  WAL mode still uses fcntl locking.

It doesn't, that's why wtmpdb is using a daemon for this.
With pam_lastlog2, the messages aren't important or reliable enough to
justify the overhead. But if you want, you would need to introduce a
daemon, too.

Regards,
Thorsten

--=20
Thorsten Kukuk, Distinguished Engineer, Future Technologies
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461
Nuernberg, Germany
Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Werner Knoblich, =
(HRB
36809, AG N=C3=BCrnberg)

