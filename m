Return-Path: <linux-api+bounces-1681-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639A90085B
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5451C248BE
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C124197548;
	Fri,  7 Jun 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGF5ChVz"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED619885E
	for <linux-api@vger.kernel.org>; Fri,  7 Jun 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773198; cv=none; b=llEmsS2ZIAS9yRXNr1IpCI52UqXhrHh5XaXeh0syX8lUlQZYuBe/nQrOTB7kUiTSYErvGEZ0peHgLZ6Kf/V5pz/RUc+CsxeXST1n6VWJOrB/G+XwuRFJvHEZEgAOo1khOK6ALWMfxWEjEWiE0KdEv75NvQdWYLOphtvzDv5+LgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773198; c=relaxed/simple;
	bh=7n0apmTpqZ+tog798fnZb4ZTZm7Gl3vutnIWL1LYnuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJ2d/9jMT8DbQD0drAOBMOQKa96ry7japQmSU+cLBwReEaEoW1uuwJZFKzx0pqnjFEJf7dLiMWOWasRenkGI6I4uVr4yYalv0T/VJySey5NGDAJE39kd0aIkZ8ozvEVmxVdGDrdF+arXes8GcRooTESyGQW67Ptwg6h7U7IJUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGF5ChVz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57c5ec83886so9066a12.1
        for <linux-api@vger.kernel.org>; Fri, 07 Jun 2024 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717773195; x=1718377995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9DLoOIliT2vV+jCDlYYVBA1v56GjGd/sBFCy6REvhs=;
        b=oGF5ChVzmkSrf4CDt2HjlSTVWxz0aYNl3lhxr2e67cX6NlsRsWve/wt9BUszmxwKV/
         KOi8z8tpmG6DM9EVZZE6v7rpbNsSJaKmwxQav+hh8XcwWF0tMjgtsZ+YippmyST/Ccc1
         HINUkWQYHln80yuBonj6B/0l4uXQ/xLdBD9n3xRqYJLSayvHUOiAJU+pK8LWVSZ2Jd2s
         yWcydFqS/ro21AUCmgZdpHYS6Mli4NdHd+3oKYvPIWhY+HxAaXYTd63tAiU6b4LdYASf
         ODfoYPGtmG202PkiEnCOF+xh+B9BE/4q8Lfh3z4hKQiEYW/OuUqqmhWzZQdFPy15YQ2J
         QTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717773195; x=1718377995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9DLoOIliT2vV+jCDlYYVBA1v56GjGd/sBFCy6REvhs=;
        b=duTwyqPJlKJUU7c20s5UJK2GM5Wn7IbyqVbcKO2BiWIaSWTHEa1jVL1waZzNGP75i6
         Z51rtRu3IiR0NPVIfK9cyPhEJCcFS47zgQeemSSElxveB1NiX0s2wde93IYPw4EXMChq
         5oWSOZnpzDxh5kaq9Pop1TZwhS3aFlfbvHk/vLUklFVMcvIjLqBx8LNEQTBAZdli8s8c
         sZk0kzLowOI6+pEOHBMAGFE+c0B+uhob5qGGMUcw/+2JCjVeEt8j+Tp2s+x2ggRyhNQW
         mya1LCS2q30hKEHLUqkp0KXcN2M4NzR41uEbo0dSdy9Mw3gZ8Rsa1du78AFrudyxgw/9
         85aw==
X-Forwarded-Encrypted: i=1; AJvYcCUgsM6dYFGrT3+9C2IJ3UjgwTug/qTi3lRvPGjLXuquRIqUqmCSEv+avLxw+4C60E2xPlWlUAlrf3gWOBlh46mQrdLCw067YsbJ
X-Gm-Message-State: AOJu0Yy++2PR8a4nV6OesAbnq+1iQxtl49mkvLgEVnTfVNWceZfjlw0y
	678znyQO+CPT0QIS3jmCXJrfpL3Ka2kdNzv5B3+zhCJ3r68gd0Je9ugMN1azADztn9KRHlqRHNv
	fME4FA50r8HsgV5L4rWRcn7tOek6xoNDJ3210
X-Google-Smtp-Source: AGHT+IGgwajHKpYdDWMQLIOmMJsfkmT9wQMD93gE5Vvy1QzU36KDO2gHuZ/Tqx8lOxhLvhtrGDMlAetFVDjv7C4htvM=
X-Received: by 2002:a50:fb96:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57aa6e8e2e9mr588051a12.6.1717773194672; Fri, 07 Jun 2024
 08:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122352.2485958-1-Jason@zx2c4.com> <20240528122352.2485958-2-Jason@zx2c4.com>
 <CAG48ez0P3EDXC0uLLPjSjx3i6qB3fcdZbL2kYyuK6fZ_nJeN5w@mail.gmail.com>
 <Zlm-26QuqOSpXQg7@zx2c4.com> <CAG48ez3VhWpJnzHHn4NAJdrsd1Ts9hs0zvHa6Pqwatu4wV63Kw@mail.gmail.com>
 <ZmMamtll1Yq1yfxc@zx2c4.com>
In-Reply-To: <ZmMamtll1Yq1yfxc@zx2c4.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 7 Jun 2024 17:12:38 +0200
Message-ID: <CAG48ez0pan8aLGjHtoDdrpiP+e5YrGeuD_RzDXgzUwkUvWYLjA@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 4:35=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com>=
 wrote:
> On Fri, May 31, 2024 at 03:00:26PM +0200, Jann Horn wrote:
> > On Fri, May 31, 2024 at 2:13=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4=
.com> wrote:
> > > On Fri, May 31, 2024 at 12:48:58PM +0200, Jann Horn wrote:
> > > > On Tue, May 28, 2024 at 2:24=E2=80=AFPM Jason A. Donenfeld <Jason@z=
x2c4.com> wrote:
> > > > > c) If there's not enough memory to service a page fault, it's not=
 fatal.
> > > > [...]
> > > > > @@ -5689,6 +5689,10 @@ vm_fault_t handle_mm_fault(struct vm_area_=
struct *vma, unsigned long address,
> > > > >
> > > > >         lru_gen_exit_fault();
> > > > >
> > > > > +       /* If the mapping is droppable, then errors due to OOM ar=
en't fatal. */
> > > > > +       if (vma->vm_flags & VM_DROPPABLE)
> > > > > +               ret &=3D ~VM_FAULT_OOM;
> > > >
> > > > Can you remind me how this is supposed to work? If we get an OOM
> > > > error, and the error is not fatal, does that mean we'll just keep
> > > > hitting the same fault handler over and over again (until we happen=
 to
> > > > have memory available again I guess)?
> > >
> > > Right, it'll just keep retrying. I agree this isn't great, which is w=
hy
> > > in the 2023 patchset, I had additional code to simply skip the faulti=
ng
> > > instruction, and then the userspace code would notice the inconsisten=
cy
> > > and fallback to the syscall. This worked pretty well. But it meant
> > > decoding the instruction and in general skipping instructions is weir=
d,
> > > and that made this patchset very very contentious. Since the skipping
> > > behavior isn't actually required by the /security goals/ of this, I
> > > figured I'd just drop that. And maybe we can all revisit it together
> > > sometime down the line. But for now I'm hoping for something a little
> > > easier to swallow.
> >
> > In that case, since we need to be able to populate this memory to make
> > forward progress, would it make sense to remove the parts of the patch
> > that treat the allocation as if it was allowed to silently fail (the
> > "__GFP_NOWARN | __GFP_NORETRY" and the "ret &=3D ~VM_FAULT_OOM")? I
> > think that would also simplify this a bit by making this type of
> > memory a little less special.
>
> The whole point, though, is that it needs to not fail or warn. It's
> memory that can be dropped/zeroed at any moment, and the code is
> deliberately robust to that.

Sure - but does it have to be more robust than accessing a newly
allocated piece of memory [which hasn't been populated with anonymous
pages yet] or bringing a swapped-out page back from swap?

I'm not an expert on OOM handling, but my understanding is that the
kernel tries _really_ hard to avoid failing low-order GFP_KERNEL
allocations, with the help of the OOM killer. My understanding is that
those allocations basically can't fail with a NULL return unless the
process has already been killed or it is in a memcg_kmem cgroup that
contains only processes that have been marked as exempt from OOM
killing. (Or if you're using error injection to explicitly tell the
kernel to fail the allocation.)
My understanding is that normal outcomes of an out-of-memory situation
are things like the OOM killer killing processes (including
potentially the calling one) to free up memory, or the OOM killer
panic()ing the whole system as a last resort; but getting a NULL
return from page_alloc(GFP_KERNEL) without getting killed is not one
of those outcomes.

