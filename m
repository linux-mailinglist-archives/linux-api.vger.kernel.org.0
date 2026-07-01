Return-Path: <linux-api+bounces-6758-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5HzcARNoRWrZ/QoAu9opvQ
	(envelope-from <linux-api+bounces-6758-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 21:18:43 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC606F0CAE
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 21:18:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ml0ih55n;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6758-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6758-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A863308031C
	for <lists+linux-api@lfdr.de>; Wed,  1 Jul 2026 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD43DDDA6;
	Wed,  1 Jul 2026 19:17:10 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EE39769F
	for <linux-api@vger.kernel.org>; Wed,  1 Jul 2026 19:17:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933430; cv=pass; b=qFAOXlrnnNqar8nyBuqGAR57dPIXDkV59LIonxnfxhb2KN2DAmpB81ZPSeUzJsyvNJpl638q69BKiH1o0kDRmr2BQyGjohR2K3QnTgq7wtRNTgY3gHmMi8I54BqoTrlPzDMXZrWKpxJo9UO/pyOUswbCntCRvzk8d9uORTxGRFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933430; c=relaxed/simple;
	bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0l88xdFPocaIlnGRFQUFyPfACkgaLb2ZYzayMqaTHFE6Ff8V8kIOu/f4AyzyRjDZQP59Rnx2HlgvNbmQMnQC70JsKIGN8NAqBhZDSH6H+nZHav5rXOPtLEPGCJ+gy12y9HT4/eh5F85a24CxTbHbLcJrNzRfPNInLUPS22kHNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml0ih55n; arc=pass smtp.client-ip=209.85.160.50
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-44cb68d549fso259656fac.1
        for <linux-api@vger.kernel.org>; Wed, 01 Jul 2026 12:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782933428; cv=none;
        d=google.com; s=arc-20260327;
        b=QJE4hF5zfGEZwztQ1T5AL2atSGow9C5kNxLrncALv/Mq4HSiVcgAEUUzRvqoyVHYwK
         2BZRM91PbfepZ5JA5KcGkM+/LBfrMCnF18h8FfVbg6F2LmoDTbYqou4xC18bfvcXkget
         6FG3BhbOwaQWCH8ynTUkUap+2h2MYz3d45hesA9Wg8tVlb/Z9B+R7xYRf09IneSfOpWq
         5TgcrLabB3bBnzioNavYJLuYgLW4cVvEuYZkidrYayA9uKLAm9lyPLQ/qnxi6DS9pOM5
         wwNdQ3AjHu3C2DiTjGTF3pB5wW5344tS/zFnVqIVeWJz2+HZFP9UUJb4ArPVgVk5OziP
         w1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
        fh=jQalAbHI0dx9aUDtqZK6gwnoirDRpWtHcw6zMwLPmkY=;
        b=L6mL3snmJejcbiBpoZAE3OeqWNzrcIRgCmm0vE7sua64bcocrzbNhCCJZxPNR99opj
         51fzIka0bBu/0pZRsOEXufAvWgTHC5ol3PFBG2Nr4/HD4G7L5ovyr+PG6yu7Voe1WewB
         fEEV21FACOfm/ScYAuA3cXcf+ZYA+E93fa3HS3C2ynkLUXiq6C95r+t8GgMTa6tDhuQ9
         RRny4MlH39l7N62iQy8FwKDnR+RCaLDARpyvamWajnozvPtNkK04rtf8G6zGr+TVKwhD
         R0uC+JNY73ZMj8b5UDIpc9+EG1YIu0gm3oK4BFkG+4OZxqzQh1oJJ39LwMyDf6Ay6EyK
         ZatA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782933428; x=1783538228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
        b=ml0ih55nsFzrKA+0lWHweYf0yqKIE40M0dLzZRhgy0Kagi1TSlkeTyLxkLZiymLcPM
         riMpj/bwV8kBuLKI0CQGgJjlIqmu1KmFxFS1AuqH00kQfaVuUTMUUJNhvTtj/QtfBqQn
         e7L/KLLhD+kOhoZkDFhmUXkYuHK+zMJQurdgZUBO42jwOb5AnA4a0Gau2bLvu7dB64rS
         2CHP8ycB5ebKneaFg4zfN0KiYx5pvZXjDqw8pdzja1zAw4v6UPiuFcbcygN7jsRdR2JE
         0P01vu7eVa5OtiHuVFLeVKP/OfK9H1BGUmoZuyXQTPUvpbpT5j5Ve1lUvYGH1XtyiC0t
         svTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933428; x=1783538228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
        b=l6cZl/YOFmMlVYoZTwAdtmNvwa/I7gzTYYL5cByQ2eJX8/G94J/54Pp8Ujt/am+3W9
         xs+rQ88Mw1LZ86d6ZyPJgi+e9BK23k0YnumxuWkQAT6UaORowf4gCT8TFA+n7MXx2mFS
         Hk5bV05yCxEe+iNswgkyVVByTGhfpnqzkNLk7vcuQnDw8B7XHPG6Zn4cHnUTtEYGwgwC
         V8wJh4pjHI1J6fRcPPBlxAS62w1PbEIG0BP1WDdf2AGcakrvok6j3CYggP8/P9UInRWN
         FDPZhyiiFyrUWFhFeO9nBv22OgYtCW3CcuES5+yd/aXZ65/9+LuO7/Vvw6uKTXqIeta7
         Kdag==
X-Forwarded-Encrypted: i=1; AHgh+RqS6QmAJTMHazzv1e2+46/f78EIS8pPMGt2s5PLyRvbg6vg2IvjX1SMrxW3SaYgUjVWSMtkM2LTeZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhNoY9ewycPHn274JgCh6ea/PNG2ppW39WFZu7h0EnQ7YHwaYX
	FHrPYpQpohTXngcQ/6PLj16EJtjWcUvgmF5CA8/3YSjBR0ZXUzxmx/Wgc0hPvVIHGxKi9217g9x
	015+nwU3djXfIdzh7Dj19ygMsp8wGnek=
X-Gm-Gg: AfdE7cnF5uz/NtqVYxtEUZNiOZHyMHq+e4bW/U2XIAvnVI2zEk3nbecYZMSshm0CVm9
	7QB39zkdRlrc3Ylv17pSZr+BdtjDN+/V+tC1XiMtTVuegaXpBIR2ieeTekBtYaa1ysGs6mVdQOn
	ulZXNrn2yOECRSzuWw4V5SLKsxUxHB4vILGHBq1p+UvoekL27lyPhcVWZtmVgwIeVhbFXUsRjcF
	KnaqvRuWg9NuYax5ImHB/qYEe3bhhjx98mTU+vctqI2OxE0eL3ADUE29BC31PtkQCpR+qE=
X-Received: by 2002:a05:6871:c8c7:b0:439:ecb3:52bb with SMTP id
 586e51a60fabf-44ae2b77260mr4418100fac.2.1782933428320; Wed, 01 Jul 2026
 12:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89ea76b3-e956-4232-8180-ee3929adf905@kernel.org>
 <20260625101132.3859505-1-safinaskar@gmail.com> <63f7860c-4f5c-4682-8914-27978b9fbfe1@kernel.org>
 <20260629-bauland-knabbern-abgeladen-c0acbfa62cc2@brauner> <CAPnZJGAJROqfCWSeeBu31HsE6nmgxVqHTNeC554S5y1Y-VN19w@mail.gmail.com>
In-Reply-To: <CAPnZJGAJROqfCWSeeBu31HsE6nmgxVqHTNeC554S5y1Y-VN19w@mail.gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 1 Jul 2026 12:16:55 -0700
X-Gm-Features: AVVi8Cfr-c-MwbiVa4Na7Gy64V9E0QAPHBSr0wHsSXCEVpPyigPKnVtNTDOprcQ
Message-ID: <CANaxB-wewdUnxApVU3yn7hqbztNJFQfN6Y8r_XZk-TZRXpOQ=w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vmsplice: fix some problems in my previous
 vmsplice patchset
To: Askar Safin <safinaskar@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, 
	axboe@kernel.dk, collin.funk1@gmail.com, david.laight.linux@gmail.com, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, kernel@infinite-source.de, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@amacapital.net, 
	metze@samba.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, torvalds@linux-foundation.org, 
	val@packett.cool, viro@zeniv.linux.org.uk, w@1wt.eu, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:brauner@kernel.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:kernel@infinite-source.de,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:luto@amacapital.net,m:metze@samba.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:w@1wt.eu,m:willy@infradead.org,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[avagin@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-6758-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,kernel.dk,gmail.com,redhat.com,lists.linux.dev,infradead.org,suse.cz,infinite-source.de,vger.kernel.org,kvack.org,amacapital.net,samba.org,szeredi.hu,suse.de,packett.cool,zeniv.linux.org.uk,1wt.eu];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FC606F0CAE

On Tue, Jun 30, 2026 at 9:01=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> On Mon, Jun 29, 2026 at 11:56=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > The amount of regression reports that we got in short succession doesn'=
t
> > make it likely that we can merge a plain degradation.
>
> Let me repeat: this v2 patchset fixes all regressions found so far,
> except for major CRIU performance regression

Askar,

As previously mentioned, this isn't just a major performance issue for
CRIU; it completely breaks the current pre-dump implementation.

The other proposed fixes look like workarounds that target specific
projects. Since few projects run tests on linux-next kernels, we should
expect more projects to be affected by these changes.

Thanks,
Andrei

