Return-Path: <linux-api+bounces-691-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED74983E6F7
	for <lists+linux-api@lfdr.de>; Sat, 27 Jan 2024 00:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBFEB250BD
	for <lists+linux-api@lfdr.de>; Fri, 26 Jan 2024 23:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013795BAC0;
	Fri, 26 Jan 2024 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjnGmr0N"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241205B5DE
	for <linux-api@vger.kernel.org>; Fri, 26 Jan 2024 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311633; cv=none; b=alDz7l/Row+r3A2rddweyYqzUSeiIIcp+/Oy0OrhD5GhJqkSw2R1lNCVB1IMbYcH89htLQcrQmpX3ZSPtMi1pct/+8++7YomXhCtKebk3zxWpbWZS6fpcJ01kivu/Dlsq4rqcyMwQThlTE0TCSJIUuYT6ziCt9Fic2J9GJJuUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311633; c=relaxed/simple;
	bh=7EM22NdD/R1gavpoQkCkmyle3YA/s2Xcz1M+2yhhH/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo1+2/1WRNCCzzZzbjLlpNQJvo56RgR5wDR6mvSaXJ0mHyUIs0TWvjbQnYI3FhAwI3Fkwe9A7D5vb/tTejMp0xzgn32Yn6Ww19vIhBKxE91uAGVvDvjYc5GBRKEx0vwCxo7clpywcTfBTye7xB/WyKFPLL0+4TvBl1TflK+uLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjnGmr0N; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso5545a12.0
        for <linux-api@vger.kernel.org>; Fri, 26 Jan 2024 15:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706311630; x=1706916430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EM22NdD/R1gavpoQkCkmyle3YA/s2Xcz1M+2yhhH/I=;
        b=PjnGmr0NqsrVvBO8j5RswZzn5txIyL2gnwtHof1jUZAPJQ5HTY+VobPciXVzhs4qWY
         GFaw5wA8DsUP61Ui8qKD1mZ0i+KCO0G55y47+MEQ8sFaw+hKn5iLvq95Cmf/Dd1B27yK
         SRslEW1uuMExqHnxJPJiJY8k5zz7tUpHBAO7Qrqwn7/6DvUQ7cKa5j6+MsDFgPdFw+3S
         gJBAeEywqgeOuZD9aKtCj1KHm1u0Hm79mmK1e5KcFuYC1nGRj1DjCyStelFi6gzTJrAi
         3vKlQVvxSba54qzrm4dvVqUSi4efUdqwBXvyHlyw5kcl4feTW6fUbH/n/64JsNx0yzX6
         Qt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706311630; x=1706916430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EM22NdD/R1gavpoQkCkmyle3YA/s2Xcz1M+2yhhH/I=;
        b=nmSkHjhT4hOXi4wC7YxKLp0J9KLZ+jaeZP1ZGzi/mp0eBPhw3EcFkyoaGRGeecfwLz
         rkGO2wInSdkw4HjDA+wxgGDJFkstdZcfg5Id+tDo2zTHumsGjvfG6lHMpP4/khf2Xg/f
         EBNKS5Zkq2+AMvYmKqxJlcdTQKBYPuSR6jhPRqfK3ivPQPLGAkj3VkttEykSuLwPNXPT
         rrFC0QmDiFZWXljKxZgwvSZcAxmIEHE+2YE23p/AgV9KAheKX/0CP8e5kUvuR0P5YL1l
         u42cAkvIeUDST15YrrbVE1Iyoc5JdT8E/V9Goea7qWaZXyvK6Xt9Udgi1cWlenlvYZeq
         hT4w==
X-Gm-Message-State: AOJu0YzHFMaIa0RbAIOC7WSYEmUY1bjDldai9hyQzM9qVHnVmQs5Qc5x
	sUO6b0lvLiZ+ica3ss51rP0Nah4Z5UooKAbqrnh5aurlfm9KhLr9JgMOkv8Y97/EHmef/1JMPev
	dr0EKaRv/ih/QQhhJw1/sV5z9UjYKM0xTZGOE
X-Google-Smtp-Source: AGHT+IEytN94Tw4OAfhLp8QPfVkL5LpSpNvojpumHJ23Z4yh5ep8lAuk/NNUIwncbmQt6kFpEx1hzb/liCn+dCwP4tA=
X-Received: by 2002:a05:6402:5d86:b0:55d:4375:c39c with SMTP id
 if6-20020a0564025d8600b0055d4375c39cmr166144edb.0.1706311630220; Fri, 26 Jan
 2024 15:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
 <CAK1f24k+=Sskotbct+yGxpDKNv=qyXPkww5i2kaqfzwaUVO_GQ@mail.gmail.com>
 <ZapwWuVTIDeI3W8A@tiehlicka> <CAK1f24m9oxciHsAht4-cCWo_NT7x+bkoXUO2HOwgMCr0OnwpcA@mail.gmail.com>
 <Za5yvjZWVyYjgyfh@tiehlicka> <CAK1f24n+pTw=7atKGAbgBh8qKOTBPq-BEV7ZkLcgN3P0n3h3ug@mail.gmail.com>
 <CAK1f24=7fKU-+xRSOhrJrZ56=YoVfnkONZwNOJRS4yY4SzhANA@mail.gmail.com>
In-Reply-To: <CAK1f24=7fKU-+xRSOhrJrZ56=YoVfnkONZwNOJRS4yY4SzhANA@mail.gmail.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Fri, 26 Jan 2024 15:26:32 -0800
Message-ID: <CAAa6QmRLfwhyh66bVVakp__Rkzpkt3zq2kAe9F-KN5sdFdqLAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: Lance Yang <ioworker0@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:35=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> Hey Zach,
>
> What do you think about the semantic?

Hey Lance,

Sorry for the late reply.

I can see both sides of the argument; though I would argue that
"non-blocking" is equally as vague in this context. E.g. we'll "block" on
acquiring a number of different locks along the collapse path.

If you really want to talk about not entering direct reclaim /
compaction, then keeping with the sys/kernel/vm/thp notion of "defrag"
would be better, IMO. I don't feel that strongly about it though.

But I see you've provided some more use cases in another mail, so let
me pick up my thoughts over there.

Best,
Zach



> Thanks,
> Lance
>
> On Mon, Jan 22, 2024 at 10:14=E2=80=AFPM Lance Yang <ioworker0@gmail.com>=
 wrote:
> >
> > On Mon, Jan 22, 2024 at 9:50=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Sat 20-01-24 10:09:32, Lance Yang wrote:
> > > [...]
> > > > Hey Michal,
> > > >
> > > > Thanks for your suggestion!
> > > >
> > > > It seems that the implementation should try but not too hard aligns=
 well
> > > > with my desired behavior.
> > >
> > > The problem I have with this semantic is that it is really hard to
> > > define and then stick with. Our implementation might change over time
> > > and what somebody considers good ATM might turn int "trying harder th=
an
> > > I wanted" later on.
> > >
> > > > Non-blocking in general is also a great idea.
> > > > Perhaps in the future, we can add a MADV_F_COLLAPSE_NOBLOCK
> > > > flag for scenarios where latency is extremely critical.
> > >
> > > Non blocking semantic is much easier to define and maintain. The actu=
al
> > > allocation/compaction implementation might change as well over time b=
ut
> > > the userspace at least knows that the request will not block waiting =
for
> > > any required resources.
> >
> > I appreciate your insights!
> >
> > It makes sense that a non-blocking semantic is easier to define and mai=
ntain,
> > providing userspace with the certainty that requests won=E2=80=99t be b=
locked.
> >
> > Thanks,
> > Lance
> >
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs

