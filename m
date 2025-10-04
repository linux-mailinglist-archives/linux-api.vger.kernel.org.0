Return-Path: <linux-api+bounces-4994-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E8DBB8F8D
	for <lists+linux-api@lfdr.de>; Sat, 04 Oct 2025 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C37189EBAE
	for <lists+linux-api@lfdr.de>; Sat,  4 Oct 2025 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84603246BD7;
	Sat,  4 Oct 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="BxG6Pd3Y"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C71C27
	for <linux-api@vger.kernel.org>; Sat,  4 Oct 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594100; cv=none; b=qGRl0wInaYteKwA/Q/pWL2MDUcH6uBMPh01kvKxpQ4K1T8Gyfh8ed3Q/xq4syX2hd0AuZBU3DiDmd9Opf5/pv5Gu6tOO9rdKe8AA1Q2zCtcZsEHwiDmsmBQc2Q61Zco5j2IwxqFBsUwq+XsETuA974G5Lq55MuJuQ5uS+jaz5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594100; c=relaxed/simple;
	bh=aDCrityIRTDTsNoHl3WYViJal3NAWy31CHFcAH4dMjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7H4w1Vrdm5uJEQFbUwzm0/edhWOIa8rX4hq9HopIgfv3PehKytXr3Yh+DRF27ZC4d1v5Obj55MteCeSfVRxvkdEIqCL8qBeSGboyD/aEAleegMxCqI3O1LeP0ZBXbhvEMs822bOO0kkgDWhov07823hZSp/Ody9+PWAHSpLdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=BxG6Pd3Y; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso3938300e87.3
        for <linux-api@vger.kernel.org>; Sat, 04 Oct 2025 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1759594097; x=1760198897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPv5+yIlETZdIyZrh1UyMYBPpswTX6QZU3krtJBLrPM=;
        b=BxG6Pd3Yj+KYxtOOfHjmqz5hyBn/IgShyvItnps7hZIKJYNrTvFuttKi8cmBN9tww6
         4wqIYCf6bk+xDtCxv/QfYelqcD7NPYexzH1upGwVvnBDFynJPvZu0RyDzxAUx56F+659
         WB8yyE4ogWi1Piz86n/lUU9NcxDsoRIe/DKYIxKQq9M4t265sGKq8vuWXmbPHtaX9kMQ
         TdjXQFjoKNDQ4BxPZ0GvVelCRdWSnvug77ti7UqsABiv7MJnr2ZIAgfpbVZ0b78o4LAJ
         GU4N5EazvijT02f/Qm1ZB/PLwdS0obbdrrktz4s4THPTkkIFETPG4zQuwMUWW7x2LZXt
         McXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759594097; x=1760198897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPv5+yIlETZdIyZrh1UyMYBPpswTX6QZU3krtJBLrPM=;
        b=P1pLn6sL3DyklAw3t2MtVdLVMRAVWvA4JDSCMO6aN6hYVaas0PJSJtzjXVOXfrOTJO
         vqIaVCBxM+cGEFnku59KODYYCnzjFd2YhuZx6ox7/0rZr6df8KeKQ1sQgDaBp3j0qz+E
         uLXiBMVcOPCbCmcz4xmZV1EmEFIplNcdBjZUOrtYZVjg2q3WHefqAjUXKp9qYVv3Lzio
         rP5IbJgQ6t4BEhHdxRXnJQRqjgjczkAT7PkCjlrj7/6aFvyOqaWRymL6xzgULELJgwVT
         V0HtwX572iD+eX09NRu5YQh3DaOMHdHk71uGN0/aHfCzOld1qORpKFYaHp/TgaMkFOLa
         iivw==
X-Forwarded-Encrypted: i=1; AJvYcCWXMpx3VryvZ2jhXlW302UHSVU9JkpZhyiYYXm6SYCZ2SGbGaPEPz3KL4mmphA9RtRR2QGKgNhUoTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPzadEI68il1o82YeKpRQNLM06CtitmRVPH0cCLLJy2b8qHNQ
	/gilagDUaQy9xt/WQouyTneKxb0JZtb4E+7H2srsu96m0syCpFzdDhiXyku006wugZhSidszHu2
	0YUVOy4VLd3Xhb1RViZr0Q+6bOA4OykqZD09oJBnFrmjJbStHN9jCjvfy
X-Gm-Gg: ASbGncukZ4el7j1oV8q9Mb5Yeq1t69fG+QZsyiGNvIQyEnum8kK7n+V8YF0Fqy+0Klu
	akcJmN3pI4qj7FUAwQZQucJ3cqj4I5I3Baxuu7ItKo/+DVHI731xkmm1RJmlbm9+TAg5JD5fi+H
	xvKOvvWvFobOmlWepPP2z1Kj1r+5HubVsS39cFOulYUg7/uDqRPRT2BcBz0nHkRcOGNrMbfiXbw
	FiCTCIynYxdSm5FmtmI/tjfllXizA==
X-Google-Smtp-Source: AGHT+IGywq3KGIlNKacCQ8JbyizpfyQvK1emwelk/96UFTAVvMbGyC8JTad2QnZqrGZIDwMlhQvVIiYjX9pd5ox8iFE=
X-Received: by 2002:a05:6512:3e1b:b0:55f:44b8:1ecf with SMTP id
 2adb3069b0e04-58cb96629bdmr2016577e87.9.1759594096459; Sat, 04 Oct 2025
 09:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003093213.52624-1-xemul@scylladb.com> <aOCiCkFUOBWV_1yY@infradead.org>
In-Reply-To: <aOCiCkFUOBWV_1yY@infradead.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 4 Oct 2025 09:08:05 -0700
X-Gm-Features: AS18NWDrqxLuc9P3rGhxlQcFOsj5EYH3mdmKe5a0v88_ynW-8nVGsUXgkNOcJfc
Message-ID: <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com>
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing O_NOCMTIME
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org, 
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>, linux-api@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:26=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Fri, Oct 03, 2025 at 12:32:13PM +0300, Pavel Emelyanov wrote:
> > The FMODE_NOCMTIME flag tells that ctime and mtime stamps are not
> > updated on IO. The flag was introduced long ago by 4d4be482a4 ([XFS]
> > add a FMODE flag to make XFS invisible I/O less hacky. Back then it
> > was suggested that this flag is propagated to a O_NOCMTIME one.
>
> skipping c/mtime is dangerous.  The XFS handle code allows it to
> support HSM where data is migrated out to tape, and requires
> CAP_SYS_ADMIN.  Allowing it for any file owner would expand the scope
> for too much as now everyone could skip timestamp updates.
>
> > It can be used by workloads that want to write a file but don't care
> > much about the preciese timestamp on it and can update it later with
> > utimens() call.
>
> The workload might not care, the rest of the system does.  ctime can't
> bet set to arbitrary values, so it is important for backups and as
> an audit trail.
>
> > There's another reason for having this patch. When performing AIO write=
,
> > the file_modified_flags() function checks whether or not to update inod=
e
> > times. In case update is needed and iocb carries the RWF_NOWAIT flag,
> > the check return EINTR error that quickly propagates into cb completion
> > without doing any IO. This restriction effectively prevents doing AIO
> > writes with nowait flag, as file modifications really imply time update=
.
>
> Well, we'll need to look into that, including maybe non-blockin
> timestamp updates.
>

It's been 12 years (!), but maybe it's time to reconsider this:

https://lore.kernel.org/all/cover.1377193658.git.luto@amacapital.net/

Nothing has fundamentally changed since then, but I bet enough little
things (folios!) have changed around this series that it won't apply
without considerably massaging.  I stopped working on it personally
because I moved the workload in question onto fast, fancy SSDs
resulting in my having bigger fish to fry.  I don't think I'll have
the bandwidth to pick it up any time soon, but maybe one of you folks
is interested :)  I never looked into the AIO path (I was interested
in the page_mkwrite path), but my series made it at least conceptually
possible to unconditionally mark the file as needing a cmtime update
when presently dirty data is written back, and I imagine that AIO
could use that too to avoid ever needing to bail out because an mtime
update would block.

To the extent that ctime is "important for backups", it's been *wrong*
for backups approximately forever -- one can read ctime, then read the
contents of a file, and get a new ctime and an old copy of the data
that preceeds the modification that logically triggered the ctime
value that was read.

--Andy
Andy Lutomirski
AMA Capital Management, LLC

