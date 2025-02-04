Return-Path: <linux-api+bounces-3146-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A6AA278DE
	for <lists+linux-api@lfdr.de>; Tue,  4 Feb 2025 18:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9974D3A4C27
	for <lists+linux-api@lfdr.de>; Tue,  4 Feb 2025 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75541216615;
	Tue,  4 Feb 2025 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgSiuWpb"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1832163AA
	for <linux-api@vger.kernel.org>; Tue,  4 Feb 2025 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691027; cv=none; b=eUk9pwcYQHqtmjmVwR1ykbpbCZoGS/uNC/Q/IrGqrT2m0H9aGnfZPt7x00Fu+T6iIFvhsyutC870Vs+S/HKaV+mXV9ItDdzERSgxle3ZmSVtf/9/rQiPOwYp6lKez1nPzjvCoggqgTs2Q+b21wM4z/JNR0iCJmVXZ6XMFgj1q6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691027; c=relaxed/simple;
	bh=RI516KF8KlF5wuxKhvy14BxpgtxjsqHgb9vmRE+RH8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6SdcL2mrBXw/MxPlEBsNEJXINtVMPGZOBbIUhQXPZAblV7lvHGxOU/FyyLo5ur6zLmGpprUqKilDFd/mc2u68X37wcMoeIbdJYiJ00zvHdlvBWaPzl6U7WQ3x3W3V8Qih7Z9Ipt79mhigxuDbZJaBKMfxt856gWQomXCzFGzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgSiuWpb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4679b5c66d0so256531cf.1
        for <linux-api@vger.kernel.org>; Tue, 04 Feb 2025 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738691024; x=1739295824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmE2lFz8a65MIXFo9x5Yc1zrZ1Lc4zxxKH4CPUa2jU4=;
        b=JgSiuWpb+YML86EJyQ2/R0EZyW8W5JETWLI3LrOJ51FIvCEAwwIly+HFiTpAgCePJA
         vm6MXrMO2k0MWYXUSlPiUeULVXSXaWBKabT6P6wjtDNJyWj3UF1F/e8Svc4k47mA2Iea
         72dGJmmXDbhk+9kBDG3FbVX68ayh5oCoUnIvdznsGVdcb0bHcZfgFjqMNwuTVWiraD+Y
         E+L0xHWR8k/VC5+Ntv8XEWw1KkasaMOEKGWYWThxtAqzcQS8cofSTFW3bmb+UdE4aTmw
         /Xtd2TRLIvikBUVr0qyfgqii6Wegi88qm8OrswFl+5LJWokLzp827YroXGaSlM6YaV3b
         EhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738691024; x=1739295824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmE2lFz8a65MIXFo9x5Yc1zrZ1Lc4zxxKH4CPUa2jU4=;
        b=fdfjKyykmfxmLIkEWUWODtSMBbEkDMl9SCnkEyD50upda2JyrrFj3p++vU/BM91ofq
         lmCor8uBoE9+dizg8xwhUXbJRwd3cQNaqh9FgApP1gU+0WhYpNbrQY2LhswtETNkjhKO
         63x0qsVYpFWnHRIqI0I0DxXnfGb8crTusibT55qDRBvx3Z7BUnugF9cB1/FdwolYV0o2
         NQgK5B1dzw5/xIKUaosvFFSkJkMlUCbVwbYQ9UuUzTpNZ3jUPmqW1/QrZFEK4S27tW3K
         Bblf35Lt72aFpCMphihAdof/1lAYkjQNJdVKoe1oeqU7EHpbWB7mf5eFOP6XzdpPgh2g
         nZYA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Dk4U9N8v+Mgu4h9Fj1XUJwRJdX/QT2rRZWlp+hkHYYHj38QrULyWJMH3Ei6PLw1QegaT/8aoibA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcbQNfrwsesADg/Dm4uCRjafA9+1v5OsrbRWHAmx/4cadAcoi
	eGLAjSwFF4zQWC+bqoqfe9VhCuffl1giGuqOtrbDUEIj7A9pDTMWBEvKHb6ezNoNyt8CPoVpxim
	bu8+GJ4NwDZr+TLR/hqRbn5YJp1W31B0HEhB6
X-Gm-Gg: ASbGncs3bSJk4jzcZwJlh062C8DGkgbYW1+wpRSqcOxwXnKcGQH2+CxiPe6p7IEcmlz
	Pp4cmtDlUw6R5nwSoU9Ow1F5NLSePwz456mrPNpC1mMwnEulToqkJ70/Q0oIRsHoMIVWtedSL4g
	TCGmpZn/pxJsG7058Zvg4mfRNyZ5w=
X-Google-Smtp-Source: AGHT+IEakkqdUEODQS4oUhl0P6nM6vpIAMS/AXypUyD79wEUNQXqWMLpkJCIqWEzIzpizWIXImCaCf1Qfn+0Gv6ysdI=
X-Received: by 2002:a05:622a:4296:b0:466:9af1:5a35 with SMTP id
 d75a77b69052e-4701901f667mr4483511cf.10.1738691023583; Tue, 04 Feb 2025
 09:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <20250204-joggen-buddeln-29e5ca75abb7@brauner> <7a8a1719-466f-4e10-b1eb-9e9e1ef8ad52@lucifer.local>
In-Reply-To: <7a8a1719-466f-4e10-b1eb-9e9e1ef8ad52@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 4 Feb 2025 09:43:31 -0800
X-Gm-Features: AWEUYZl7RlmyhEU99QQ-tyghSf0sZ-KKDjjpT9EgshNSpko_7zG64QXhfE_k9kk
Message-ID: <CAJuCfpEUusRt_ss7RtxRPP9q_LRwi+Lw+SOq32EUA58s3JOx1A@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Elliott Hughes <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 2:01=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Feb 04, 2025 at 10:46:35AM +0100, Christian Brauner wrote:
> > On Thu, 30 Jan 2025 20:40:25 +0000, Lorenzo Stoakes wrote:
> > > If you wish to utilise a pidfd interface to refer to the current proc=
ess or
> > > thread it is rather cumbersome, requiring something like:
> > >
> > >     int pidfd =3D pidfd_open(getpid(), 0 or PIDFD_THREAD);
> > >
> > >     ...
> > >
> > > [...]
> >
> > Updated merge message. I've slightly rearranged pidfd_send_signal() so
> > we don't have to call CLASS(fd, f)(pidfd) unconditionally anymore.
>
> Sounds good and thank you! Glad to get this in :)

Sorry, a bit late to the party...

We were discussing MADV_GUARD_INSTALL use with Android Bionic team and
the possibility of caching pidfd_open() result for reuse when
installing multiple guards, however doing that in libraries would pose
issues as we can't predict the user behavior, which can fork() in
between such calls. That would be an additional reason why having
these sentinels is beneficial.


>
> >
> > ---
> >
> > Applied to the vfs-6.15.pidfs branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.15.pidfs branch should appear in linux-next soon.
> >
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> >
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> >
> > Note that commit hashes shown below are subject to change due to rebase=
,
> > trailer updates or similar. If in doubt, please check the listed branch=
.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-6.15.pidfs
> >
> > [1/6] pidfd: add PIDFD_SELF* sentinels to refer to own thread/process
> >       https://git.kernel.org/vfs/vfs/c/e6e4ed42f8d8
> > [2/6] selftests/pidfd: add missing system header imcludes to pidfd test=
s
> >       https://git.kernel.org/vfs/vfs/c/c9f04f4a251d
> > [3/6] tools: testing: separate out wait_for_pid() into helper header
> >       https://git.kernel.org/vfs/vfs/c/fb67fe44116e
> > [4/6] selftests: pidfd: add pidfd.h UAPI wrapper
> >       https://git.kernel.org/vfs/vfs/c/ac331e56724d
> > [5/6] selftests: pidfd: add tests for PIDFD_SELF_*
> >       https://git.kernel.org/vfs/vfs/c/881a3515c191
> > [6/6] selftests/mm: use PIDFD_SELF in guard pages test
> >       https://git.kernel.org/vfs/vfs/c/b4703f056f42

