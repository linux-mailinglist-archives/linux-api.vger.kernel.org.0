Return-Path: <linux-api+bounces-4687-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9FAB40A7A
	for <lists+linux-api@lfdr.de>; Tue,  2 Sep 2025 18:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF8E7A3602
	for <lists+linux-api@lfdr.de>; Tue,  2 Sep 2025 16:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6D730AADA;
	Tue,  2 Sep 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoU2TcIN"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719EC2DEA64
	for <linux-api@vger.kernel.org>; Tue,  2 Sep 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830241; cv=none; b=TkMndSrIiwCMS2KzF3eo4Sh+fm4R3mHza9gAUK2thOLO8qBBLjDQmGgJR1sOFQ+B6faI0SQaNTNN+XTNa/F+ZfwGxR49hapwIv2+p4zY53G9z0bxwd8Bnj9KfXsu63yt+DqQFyXfqd3jtm+RJnOXYLYMEgzOWiJO2kZvBUPuayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830241; c=relaxed/simple;
	bh=X43P8Jku/sIWXNI/fwCWJqs0MCk2Sn1XUq0PjuJjxC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkqK+EatnBMC7a1tTfsO8hKRWxWgkK49Cbrvp+wIKViunboNCNNrHQsizTJkTH3EkpcMn9y+ZvoUmOkvqsR438mJvi0yvezFpkjr6pJhA0lpBACXjHKyyTNhkvvQyggMucvGTW/DiNiIY4VLUdNFroWhtKAq5HUw4pc56zHd/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hoU2TcIN; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-315bb486e6dso2987090fac.2
        for <linux-api@vger.kernel.org>; Tue, 02 Sep 2025 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756830238; x=1757435038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wscy3tPlqi5U19UhZsY8jeanG0t7BSD1BDHTF0J1QCk=;
        b=hoU2TcINJipUiFVnhf85w2hWzwCSMttOuu0RQ+z4A751arrYvZEwOTAlwlgGbzTIQf
         uougeh6KOREhJEXrDY48385TDEB5irIkBMc8DbUW1vgf8oXCyPIbdnu79UwtvlFM2+I7
         ME6Kn1SnUHQl6JqXy+oBlwvp1kdKlr7hywCeKNA79O2HK3/MSEgottsT5HiC0ewlircE
         p3EHzfcjPOz5Ml5l58ZOfRnIRS4Kief+c1fLRTN9RWuzX9VlB6UCBF2ahI3JFUdvH0KQ
         K+p5r54mQEFRpcetoFA7NfHxOSR0Mes8NU3R+VCC0zFO8K4m22fp5QReHzHWDiJHkINP
         Mn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830238; x=1757435038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wscy3tPlqi5U19UhZsY8jeanG0t7BSD1BDHTF0J1QCk=;
        b=HYHI9ws0aNNw6tbhc8YEHFn2JyUHJCHNewdi0JK14xqQ2gWdgC0sfpbSIc8LfLZGyu
         WAVRH90p0iCr8EhERBr7Wov05md9KIfeQD5+7fDN/q5zRH/wKW/AVlApUAcamiljnOQx
         OVdA1k85o7RuBhZ3UY9x4HzknZsvVPTzozc4PA/zft8BYGNqLhLSlSESVBBuacbEwTqP
         fOvsojSaYkkiqR5IBiTf2vnm3f6guMrJWD4+LThMMjKfJ83p9W6y+OHrC6gAjcbeixyr
         bmNFDOo+uPioBjKB5NcXVj6h/dKPGK0+w0j5kPCvdsfOvF/yL8Gs1ttRO+uj9+T43DB0
         bTVA==
X-Forwarded-Encrypted: i=1; AJvYcCUqLDMLYPUmN7al7nA6/nQl3bghH3hN3gOS+NSluYjHsEqVQZ++b4LErZyk3Q96YPqpEsjZLqRkd2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSYwqjYz6E2BhophS4N5Xrp9NzfGy5jjwjY1IZTPeIbJTvk6c
	vppNIKrFN4d/yMWjaMaKJ/wyNB2mGmOX6uEpQNvi/03CDoDYGu8x2i1vCJQf5aN6kzOOYb/aIUB
	iGlWx7mT19WMNiGVSZ3n+QdXJHKp9E4yfiFeEA67n
X-Gm-Gg: ASbGncsTbDBPz42HekTk9Fe+gpVs6PyDbO6PFXn312BfkneLhFVbc0KKpHGEHuxhb42
	hnkDoVwrCXJ8g99n62C5I0NvuHVQYEjoZo3QEzalt1karPzyJ+9bk/mUgmS/+TXkiWVuTebu/kZ
	2v4qPDLR7ZpnEI9+nNn0VDHsblarI3yatzO0Ri9MoOs50hqHkzm12uyqug7t18cftibJ24wwzEU
	OiH5cR6QPg+mRPfwQuuuA==
X-Google-Smtp-Source: AGHT+IEmql8akxVsiv1uquWfxZbJZ9CvU781G7C2t2+/8BV34tPtMu8gh6e7sOFNjjJeZReCpv3wEFU6eHlu6bn8ERY=
X-Received: by 2002:a05:6870:1705:b0:319:625d:31a7 with SMTP id
 586e51a60fabf-319633ce913mr5789499fac.34.1756830238176; Tue, 02 Sep 2025
 09:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c5ae756-c624-4855-9afb-7b8e8ce91011@linaro.org>
 <828f6dfb-7402-45e1-a9ed-9e17b6356c5c@linaro.org> <2025-08-25.1756160579-pudgy-swank-chard-regalia-j3jdtD@cyphar.com>
 <5c3b9baf-76b4-40d7-87fb-9b8dd5afd1ee@cs.ucla.edu> <2025-08-26.1756212515-wealthy-molten-melody-nobody-a5HmWg@cyphar.com>
 <6432a34d-fba9-414e-ad38-d3354fa0d775@cs.ucla.edu> <2025-08-27.1756273344-decaf-ominous-thrift-twinge-h1gGBI@cyphar.com>
 <5c9fa556-da00-4b76-8a70-8e2d1dddd92d@cs.ucla.edu> <2025-08-27-perky-glossy-dam-spindle-kPpnnk@cyphar.com>
 <5cbd7011-9c2a-4a23-bbce-84c100877cdb@cs.ucla.edu> <2025-08-28-foreign-swampy-comments-arbor-nOkpXI@cyphar.com>
 <cbbc9639-0443-4bf8-bbd1-9d3fdcb2fd37@cs.ucla.edu> <CAG_osaYc21nR0M3O6UKs8zna6x_k9U4=Rt4B0mKHog=ZLSH1AQ@mail.gmail.com>
In-Reply-To: <CAG_osaYc21nR0M3O6UKs8zna6x_k9U4=Rt4B0mKHog=ZLSH1AQ@mail.gmail.com>
From: enh <enh@google.com>
Date: Tue, 2 Sep 2025 12:23:46 -0400
X-Gm-Features: Ac12FXxzj3Z1wiB8BkP12lxO4z3aAWEKHcDttgGRuXtH2ynRu1nOTHQpnvmsTo4
Message-ID: <CAJgzZooK+w7NTjsFV_0c=SmPSnsSMiWXFgnvcw=w3msj7NBY9A@mail.gmail.com>
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
To: Arjun Shankar <arjun@redhat.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>, Aleksa Sarai <cyphar@cyphar.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, libc-alpha@sourceware.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 10:42=E2=80=AFPM Arjun Shankar <arjun@redhat.com> wr=
ote:
>
> Hi Paul,
>
> > On 2025-08-28 01:42, Aleksa Sarai wrote:
> > >> I still fail to understand how a hypothetical "give me the supported=
 flags"
> > >> openat2 flag would be useful enough to justify complicating the open=
at2 API
> > >> today.
> > > My only concern is that it would break recompiles if/when we change i=
t
> > > back.
> >
> > OK, but from what I can see there's no identified possibility that
> > openat2 will modify the objects its arguments point to, just as there's
> > no identified possibility that plain openat will do so (in a
> > hypothetical extension to remove unnecessary slashes from its filename
> > argument, say).
>
> While it is true that openat cannot be extended in this way, for
> openat2 (whether or not it eventually materializes in Linux) there
> already is the RFC patch series proposing CHECK_FIELDS that Aleksa
> referred to earlier. And it's not just that: it has been mentioned as
> a potential future direction even when the openat2 syscall was
> implemented [1]. I think we should interpret this to mean that there
> is indeed a possibility for openat2.
>
> > In that case it's pretty clear that glibc should mark the open_how
> > argument as pointer-to-const, just as glibc already marks the filename
> > argument.
>
> Unless the kernel marks open_how as const, glibc marking it as const
> can lead to additional maintenance complications down the line: in the
> future if the kernel starts modifying open_how, glibc's openat2
> wrapper will no longer align with the kernel's behavior. At that
> point, glibc will either need to discard the const (which will cause
> any existing users of the wrapper to fail to recompile), or glibc will
> need to handle the kernel's new behavior in the wrapper (which will
> lead to further divergence from the behavior of the syscall that we
> would claim to wrap). Neither of these seems problem-free. On the
> other hand, following the kernel's declaration will mean that should
> the kernel choose to mark it const, we can easily follow suit in glibc
> without breaking recompiles.
>
> Earlier on in this thread, Aleksa mentioned sched_setattr as
> establishing precedent for the kernel modifying non-const objects. It
> looks like glibc actually does provide a sched_setattr wrapper since
> 2.41. The relevant argument hasn't been marked as const and the kernel
> does modify the contents, and glibc's syscall wrapper simply passes it
> through. So we already do this.

given that

SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uatt=
r,
                               unsigned int, flags)

calls sched_setattr(), which is defined thus:

int sched_setattr(struct task_struct *p, const struct sched_attr *attr)
{
        return __sched_setscheduler(p, attr, true, true);
}

i think that's just a copy & paste mistake in the kernel -- carefully
preserved in glibc and bionic -- no?

(i only see the kernel updating its own _copy_ of the passed-in struct.)

> Based on all this, I feel that leaving open_how as-is is the easier
> and more maintenance-friendly choice for the syscall wrapper.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
>
> --
> Arjun Shankar
> he/him/his
>

