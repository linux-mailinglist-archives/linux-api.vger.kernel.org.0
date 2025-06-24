Return-Path: <linux-api+bounces-3955-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00314AE68EC
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417B03AB7F1
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82CA2D1F72;
	Tue, 24 Jun 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVXza9or"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD11F3B9E
	for <linux-api@vger.kernel.org>; Tue, 24 Jun 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775440; cv=none; b=mG/7i23xz6RNYV1j5WAxoeDT4DqgeBEeoF3hyUT04DgBHczkxF8ErP+Qfwj7iFQQffeO3mMqK1hFX43kZX+pYxs68y+3BkMW/VDkkTitaGD6MGckHYshL7YZnuRfkFEHPkf40aPlh9IstLzLvYDhRrGxvW+2RuXldWITzzQZMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775440; c=relaxed/simple;
	bh=nD6d1oQU0U6CEQ1PjJb3tKi1fzkMIlIjezBHP9gjyFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsJQFY/ts9NWeub8zVz4Rgy842ID5eyeN0fOZjdkU3HXVkjDcRRzMY7sV97/vjyvPI36MwO0A40BSV+EhCLssGck4j9QkaBXVf8bGnY818OyF5T2jqMvZqmmdyrCIL9ycAy397QDU5r+XgwPfmgGP44b4jQg1iSKSmUA/b9ZBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVXza9or; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df303e45d3so658335ab.0
        for <linux-api@vger.kernel.org>; Tue, 24 Jun 2025 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750775437; x=1751380237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nD6d1oQU0U6CEQ1PjJb3tKi1fzkMIlIjezBHP9gjyFE=;
        b=pVXza9orz/i1vTC6WD5SzWZ+9Z3/DY5r2DSictTUKkTInwmPH5OnYzr5WG6eQIcW4W
         odMhv0h8vNFRwKNkNlNS+U0C02sBlt5TwnjM+exmHAKBF6+EEAbMPKZulwWcpMHZMqkO
         Qo703bL29SunEIMVfZO3e0PM0e55g3w8kCeWzjTvsjR2Vd2A7XcdQqPZd9MLfj0wK4bT
         PoFYQckPL6q/xJo9uuoxq2yeVcWVPRiWhyZoYoH1iJfMgO2liLA+f1uoo6t4LIAYMiyV
         vZSDkZ+caPSH9YMUfYueiQrC1xdi+wyQeKIU9L/0J7eLrPqvdtPEkyAb/SHP0Ti4NAjX
         97/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775437; x=1751380237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nD6d1oQU0U6CEQ1PjJb3tKi1fzkMIlIjezBHP9gjyFE=;
        b=mY+ZsHbbHHoadRWk0hlurhTrL74L0kZ/FNGsdiKd+BkG7asfF7w2/7dqLteuqs1/2h
         tyxc7zukDl5fqs3gTiRVVzBHI5GIqMYz/y+T21/fzcS8Ylbx1M6IJAYsJiIsxxsGzfDm
         1QlFJw0X1zlkqjxy01UIDIH0TU5Ucl6nNilOovK0kuyYxDMjOqTkhC40pYklSHTvruzd
         oCZTx0Xldg7+D0RO/M93SzJk+6wiUmlkovyFYD/42nn7JIAzoO0Ux3wzB0KrFZYiTgvq
         FBfnn71zqrUsS2a2vWOnDuUGC4ek/YWk9Gf1bSN9cgZBj/OU5TtIThj3MUHggFfZ6FbB
         dfgg==
X-Forwarded-Encrypted: i=1; AJvYcCVdMb0O54mzj3SO6eagHMYRN2o0pPE7KD3OSPo5WhUNnwuaGzdT5DSgl3ITKOBiYcuEjH3Wpw+5WtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5U3vT7pfr7vAaEfh9MpYwLH58s/YHIXIJ01A0ssTfUna7E6g
	Y6r2q8Y84YEnAmI1F+/yNoFj7NaAhWfl02YOfXWEl4TGua2SViL/GCcKcFfmMIqw3r0CyUxw7oj
	+9g8C6Hw6dCCT0DKhIP+zoMkrZgpIjnz70T2wx9ZY
X-Gm-Gg: ASbGncuzyg293yumMLAbnKghMLg7ca0N4+idt2HHT3x7+qm6gcUbOcwO2D0sVNITMXr
	4NTJW+G6FJn42kH4m0HN1RrOlFwoIkydQoQUkQnKD+oxb1w37HtUivLGXRuDvLLzBownxs/JADT
	ut7hfHKAcLDfMYtiil7F2z0W8lhecZVOJAB6dlsdUuew57oViZC12m46/qkNica9XfyeDCV3fv
X-Google-Smtp-Source: AGHT+IEHixcelKr3ZDZkYGsXMHko5Eg4schrz3wOXp27EKQA6K+fy348hW6r2MyxxJ0URo5kPr2rZaqYfCP2unLWoUs=
X-Received: by 2002:a92:ca0e:0:b0:3dd:bfba:ff9c with SMTP id
 e9e14a558f8ab-3de38ca2a44mr177442515ab.11.1750775436923; Tue, 24 Jun 2025
 07:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFNYQkbEctT6N0Hb@lappy> <20250623132803.26760-1-dvyukov@google.com>
 <aFqw5-PO4MjsEdYU@yuki.lan>
In-Reply-To: <aFqw5-PO4MjsEdYU@yuki.lan>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 24 Jun 2025 16:30:23 +0200
X-Gm-Features: AX0GCFsbVHjLUySg8qRCEV1aKqnjgETI6fmZpybrMY1RcxRtsY4qbFVJBY3VhYg
Message-ID: <CACT4Y+Youc3M0z0U9arrTgyOC1+UKytav4zObhjUXn8-RLThMQ@mail.gmail.com>
Subject: Re: [RFC 00/19] Kernel API Specification Framework
To: Cyril Hrubis <chrubis@suse.cz>
Cc: sashal@kernel.org, kees@kernel.org, elver@google.com, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, tools@kernel.org, 
	workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 16:05, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > 6. What's the goal of validation of the input arguments?
> > Kernel code must do this validation anyway, right.
> > Any non-trivial validation is hard, e.g. even for open the validation function
> > for file name would need to have access to flags and check file precense for
> > some flags combinations. That may add significant amount of non-trivial code
> > that duplicates main syscall logic, and that logic may also have bugs and
> > memory leaks.
>
> I was looking at that part and thinking that we could generate (at least
> some) automated conformance tests based on this information. We could
> make sure that invalid parameters are properly rejected. For open(),
> some combinations would be difficuilt to model though, e.g. for
> O_DIRECTORY the pathname is supposed to be a path to a directory and
> also the file descriptor returned has different properties. Also O_CREAT
> requires third parameter and changes which kinds of filepaths are
> invalid. Demultiplexing syscalls like this is going to be difficult to
> get right.
>
> As for testing purposes, most of the time it would be enough just to say
> something as "this parameter is an existing file". If we have this
> information in a machine parseable format we can generate automatic
> tests for various error conditions e.g. ELOOP, EACESS, ENAMETOOLONG,
> ENOENT, ...
>
> For paths we could have something as:
>
> file:existing
> file:notexisting
> file:replaced|nonexisting
> file:nonexisting|existing
> dir:existing
> dir:nonexisting
>
> Then for open() syscall we can do:
>
> flags=O_DIRECTORY path=dir:existing
> flags=O_CREAT path=file:nonexisting|existing
> flags=O_CREAT|O_EXCL path=file:nonexisting
> ...
>
> You may wonder if such kind of tests are useful at all, since quite a
> few of these errors are checked for and generated from a common
> functions. There are at least two cases I can think of. First of all it
> makes sure that errors are stable when particular function/subsystem is
> rewritten. And it can also make sure that errors are consistent across
> different implementation of the same functionality e.g. filesystems. I
> remember that some of the less used FUSE filesystems returned puzzling
> errors in certain corner cases.

I am not following how this is related to the validation part of the
patch series. Can you elaborate?

Generation of such conformance tests would need info about parameter
types and their semantic meaning, not the validation part.
The conformance tests should test that actual syscall checking of
arguments, not the validation added by this framework.


> Maybe it would be more useful to steer this towards a system that
> annotates better the types for the syscall parameters and return values.
> Something that would be an extension to a C types with a description on
> how particular string or integer is interpreted.

+1


> > Side-effects specification potentially can be used to detect logical kernel bugs,
> > e.g. if a syscall does not claim to change fs state, but it does, it's a bug.
> > Though, a more useful check should be failure/concurrency atomicity.
> > Namely, if a syscall claims to not alter state on failure, it shouldn't do so.
> > Concurrency atomicity means linearizability of concurrent syscalls
> > (side-effects match one of 2 possible orders of syscalls).
> > But for these we would need to add additional flags to the descriptions
> > that say that a syscall supports failure/concurrency atomicity.
> >
> > 8. It would be useful to have a mapping of file_operations to actual files in fs.
> > Otherwise the exposed info is not very actionable, since there is no way to understand
> > what actual file/fd the ioctl's can be applied to.
>
> +1 There are many different kinds of file descriptors and they differ
> wildy in what operations they support.
>
> Maybe we would need a subclass for a file descriptor, something as:
>
> fd:file
> fd:timerfd
> fd:pidfs

FWIW syzkaller has this for the purpose of automatic generation of test inputs.

