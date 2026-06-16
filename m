Return-Path: <linux-api+bounces-6616-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mLBdFW/vMGriYwUAu9opvQ
	(envelope-from <linux-api+bounces-6616-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 08:38:39 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DF68C92F
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 08:38:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="TCdyfq/c";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6616-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6616-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24D06302D323
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 06:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FA23EF0DC;
	Tue, 16 Jun 2026 06:38:22 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5023ECBED
	for <linux-api@vger.kernel.org>; Tue, 16 Jun 2026 06:38:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591902; cv=pass; b=Z26kFdcTsVDuIO1y6rzRrhTyoaY7a35gOULzPXoXW5hzDccG0OpTHABZWAu+qzbY3t2emPg/YYtwUBct3ipvZ70LQasdD6GzyBWsjj+6yKt81ElwjxLbp13xtIRMKkn9izuhoXtpJVEYNU0xRnDGXy8Ob/z27sCpGQxoj4sWN1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591902; c=relaxed/simple;
	bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+ek3CsglOkwz/VYYysLOhlirx708JelCuE9TxBd67doZC5cbs0mFb0BmseHlMKURTC9RdbieTkG4nL5UoEhES0F79i4OtsNRpbjigQ4EfiBKT1X8pXw3BYkCuO5eJwQrNidtfrMdzurEEZNGwUHcg4FZQMaRKOsARoytvZmjCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCdyfq/c; arc=pass smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef1198766so2185093f8f.0
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2026 23:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781591898; cv=none;
        d=google.com; s=arc-20240605;
        b=BPTpTNOxDOWcWDWVOX58ZZTNqRyvq0PG20nk4iWZ7vUWHAqx06q1FossjqH3ngv4on
         68l6t8jFweIt3ePAUPe4C419mEjrUqtL+zZpOKVu+gOt/r1vwrKucka4cFrhLhWTB1yQ
         Xi9y2IdAsPOA+mzaDHPegyzQoTPZ1JvdbLrpvhgNx/IduiZnyxZDkkf1zbHcwS1qDWvK
         QVwieRLZc79lf3Nh3ML/1WerVgu00m4G374SlaiZMMKGzw2eI67OdoTbCed7EyGlglnt
         1gKiNiKbFezoQTMgeed67UjUL9hS3zlVLWIs3CdClvaezVYQG6H1cHJCQ1CZHXFNTuys
         2CUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
        fh=L8+pldL00Jedh+LVaMQaIilZJ94hiF0/G9/WAMlBvJU=;
        b=UcY1Q7yHmx19sg49E1tgmpLMHqBawCxAs3Su3x87TmiSj5clNO60fBJpeJ6pGpznnO
         IPzPpvlCcPm8mQJ+jAUffpHtCiTjpunydzN4cqRsWBzUFSwYKOoHvZ7zhCpnJHInJ2tq
         1Y3CXZnrqBWUW6IbOs8WmftrGaublTOdGtvUPctBojAK3P4nvDbBQ+5Qc4MsfObckcd0
         Nht+2ca8ni0ihPTOIAlwqCtiWCD/4sc9rcRZeY6iHDYNvYxU+lF4PYUAL+BXeY2NvKfE
         9raDmbOZKaq2R5w6jQHfBN0Mo5NHcYoM3DHM+ZjQqevk+3YPtCP0hji1UAGfTkRKTXtr
         orAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781591898; x=1782196698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
        b=TCdyfq/csbwNTDXoi0an5Gyt2xnpYlXssRzAw7yl/QEXZK9cE9pdxwEc0QL26TL4z6
         A2gG862fFBUtL0pim6vgby3kjkGNb29nJTCgTRNEP0QI6MKUA2YNCJaRExhsFwQ0hzr4
         ZivENrblWimzl5P7+92X7IvsD9yMi1umN1g61OaObNghB50ddmvw2TNeBUHa4WtS4iL2
         tSLByc52ayqAAkfEXAf8k7l7kB0591ppCMH0DThaSunxQ6R4m9O79zFq3g3JddhQVTRs
         I9xObag+6bPi0MWr8QHTYGpw8/XXW2NUcr58eFgRL4mbdXNaWIqSEI+uhtSGaWTvW8xD
         0ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591898; x=1782196698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
        b=ZAF7mf7qpHQffKn909m783qCtMdKMOQWA92ZAepj3U5PF/tojMPbtgURiqpXnE7Emp
         A8HD0OVGkxK7cwhQdclg/ooI++D2IS7NDh6yJIsWjbBDQG13jKgFtG8NiEfOgV9WS6hr
         2OBMts/8VBktFY+udQpj1mm/Nn+U7slpToKZtJXbLPtOurlKvn6ZTz4XTbl8Hxq0MH58
         yxiTKIL5yt6mEJk5jUyVvIThSi1TbdQSIajEfSAhpNCuG7xdms72fFhE/PP9jbSkGFqc
         bW6lsev4uWc6NbLnkGOdDxPtkR6m0GIoaTILI5l/voDxt0vo1dC7Y9D32eIBmbvcag5H
         3VBg==
X-Forwarded-Encrypted: i=1; AFNElJ8atvYQ/4vGCptQSIFTOgOOsvWAcWmnftxD9O/CGurC/dsadfdl0TKWKZ7kluyfdC0Y5qSEoTXJiQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycdflNFYclN7Grx9ZtYuomCOXry/p4ls+7jUaYBgBhmkUGUKRk
	cWLZ9p31/97YuWnoBWwd35KynOcnrXvYCX9qGXIOI8WdpjiEcLgAicDtyv6ciqr9WtiSHDMnT0Z
	ZJTJOLF83lWRAIsjzhF0pDHPfVNkiiEk=
X-Gm-Gg: Acq92OGhsJpfVhL0jHaSSfbC49vIQF0x6JzJUZY/YRY85Cz7zGKHny2x9HCqVM7Yx/V
	Kbboy8ic3T97mw5EbpyxiSMo6B0ACLaKsPvJCo3dTnfcqweikfUy+MfLw6GBbdTgGS20tMAWAKU
	24wX49aw7ip0qA03jO2VWWRDVDSjGKtOYUL36WdO50F97tcaPCZy0/WPBB6Z6ZcCivsuzy8B3LW
	jB9WDpcRPVYCfEttdmShabtbTPU0HaQdXEuFgk0NAlQmTjsQjT7e5sSfA2Tj/tTfC5iW7yAPxrA
	BJyq8ys4yqmjkMVp5caBFNoP7UNCOkWQQvgXMIclT7vbmdIIC/BaxbjKBBkJhI89KWEXo2/eFVB
	kGQ==
X-Received: by 2002:a5d:5d11:0:b0:461:a19d:3547 with SMTP id
 ffacd0b85a97d-461a19d361emr1794950f8f.19.1781591897693; Mon, 15 Jun 2026
 23:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
 <20260616011516.4039110-1-safinaskar@gmail.com>
In-Reply-To: <20260616011516.4039110-1-safinaskar@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 16 Jun 2026 02:38:05 -0400
X-Gm-Features: AVVi8Cc6TBHBfR45WJ_2epcrLUaiFCORhANibC721wRIalY3QlqXFyIm-p-MJJQ
Message-ID: <CAJnrk1Z_V8TShvWV6zwTMQqXra3J4J5CL5ofFMm9DGoLj9whEw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, bernd@bsbernd.com, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	fuse-devel@lists.linux.dev, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	rostedt@goodmis.org, torvalds@linux-foundation.org, val@packett.cool, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[joannelkoong@gmail.com,linux-api@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6616-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B87DF68C92F

On Mon, Jun 15, 2026 at 9:15=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Joanne Koong <joannelkoong@gmail.com>:
> > > speaking of fuse_dev_splice=E2=80=A6=E2=80=A6_write actually, this se=
ries has broken
> > > xdg-document-portal!
> > >
> > > https://github.com/flatpak/xdg-desktop-portal/issues/2026
> > >
> > > Specifically what happens is that the EINVAL is returned due to oh.le=
n
> > > !=3D nbytes:
> > >
> > > fuse_dev_do_write: oh.len 16400 !=3D nbytes 15526
> > >
> > > (where 16400 =3D=3D 16384 (read len) + 16, 15526 =3D=3D 15510 (file l=
en) + 16)
> > >
> > > After reverting the series, there is no error because oh.len
> > > becomes 15526 too.
> >
> > I think this is because of how libfuse handles eof / short reads. When
> > it detects a short read, it fixes up the header length after the
> > header was already vmspliced to the pipe because it assumes vmsplice
> > mapped the header's page into the pipe by reference. It assumes that
> > modifying the header length in place gets then reflected in what the
> > pipe later splices out.
> >
> > The logic for this happens in fuse_send_data_iov() [1]:
> > a) sets out->len =3D headerlen (16) + len (16384) =3D 16400 in the
> > stack-allocated fuse_out_header
> > b) vmsplices the header to the pipe
> > c) splices the backing file to the pipe. if this hits EOF, it'll get
> > back 15510 instead of 16384
> > d) detects the short read [2], fixes up the stack out->len =3D 16 + 155=
10 =3D 15526
> > e) splices the pipe to /dev/fuse
> >
> > After this patch, step b) is a straight copy which means step d)'s
> > fixup doesn't modify what's in the pipe. This could be fixed up in
> > libfuse to not depend on modify-after-vmsplice, but I don't think this
> > helps for applications using already-released libfuse versions. I
> > think this patch needs to be reverted.
> >
> > Thanks,
> > Joanne
> >
> > [1] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#=
L846
> > [2] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#=
L956
>
> Uh, this is very unfortunate. But I still want to remove vmsplice.
> Maybe we can somehow save my patchsets? For example, let's return EINVAL
> for this particular combination (writable pipe + SPLICE_F_NONBLOCK).

writable pipe + SPLICE_F_NONBLOCK is a valid vmsplice call today, so I
think returning -EINVAL would still cause regressions. It happens to
be a workaround for libfuse only because libfuse falls back to
writev() when vmsplice fails, but I don't think we can assume other
callers have the same fallback.

Thanks,
Joanne

>
> --
> Askar Safin

