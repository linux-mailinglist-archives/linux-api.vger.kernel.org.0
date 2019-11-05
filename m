Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018FEF03AF
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 18:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbfKERCs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 12:02:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38108 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388739AbfKERCs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 12:02:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id q28so15732199lfa.5
        for <linux-api@vger.kernel.org>; Tue, 05 Nov 2019 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LbJPI0FDJ0eEH2iVM7vPGyU9geutYVr1qL8gmhIfHE=;
        b=QDlUNpXdd3Dyvqcp0bF9C4VAE6LpyEAfN3KCcFBDOBEqH3n8L0ZpW+QnevnXgO+jYu
         Qk8o1QZ5B54+yqYQT3t1wn/SYX8uoo4FtQ1RoMpU13Ly74nWaZ0DpB6c+SSSrHAm2jOf
         zyStjxIvVVyjTHDy76iWx/Fk+mv4DLTBXicRDuPGAVTUhNzNrCPpjPK7KNIliqLxmqiB
         7T85gjDMOw7LSetpqnnY8SLtjNFCld4SIVi8OEtT4kdKKV7JOiysKXHmaTOJOxh+RA7i
         sp0okHC4thvaKKudFX+HbfOenxmYBJ8YHGdTvAjMhkrw0vRQ1VRkfjrtXACS9VQBneMH
         4yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LbJPI0FDJ0eEH2iVM7vPGyU9geutYVr1qL8gmhIfHE=;
        b=ce0HzcT63rbzvTH1AG82dQz5wsBklhiK8D42DgyW/D8/V1kOic36rhj6M0nvJFE6Ba
         T7nrijPbDtVTWWj/DdfHH3i6Pt7Wm/N1MdYgQVYTaCUAncxnwPogxw4KAixPzodjm7ZI
         J1Bwclk0d6EO8PqyZPJlIEmN8rvQQtgP/IcX/86e6RJeIIvjFNHZHr9eD6UQX8ZrareR
         A+YD+qMjEsupx8WFfYahwNeRQ/Ng/YjxnWnVLoUkWRmFhn4bcwSX+DsugiXZP0KGJW7L
         z3cIaBM/e1XLUuSAPb28PES2g56VLf8GRw+fpErodJRwOpXmvKsXCiT3RKgg3wghzyG/
         6aUQ==
X-Gm-Message-State: APjAAAWCEe+N4Ox4udj2cC914uTAwMYQmCmzhEiNTLtRJ3pp677hOFJL
        YTAPEURci/Zh+xXgqcxKb+d5+bwjpqVYh+7kt1sDzQ==
X-Google-Smtp-Source: APXvYqxoAZZ3CBPgeWIOEoK9yoKNl+AObjnu16/uWXH4QNCI609JrFh7R0bTPoVuzjjLAldIucXdfUSSf/LzD/JxH1Y=
X-Received: by 2002:a19:8582:: with SMTP id h124mr9689722lfd.64.1572973365922;
 Tue, 05 Nov 2019 09:02:45 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <CAKOZuetu0QWUDAycTOFzC4HEbjH99EtOhb4gJnHAuovT_StpzA@mail.gmail.com>
 <20191105163316.GI30717@redhat.com> <CAKOZuet1Hrdd7U4VVBmXNCkE6xwiUPERRHjP=A3bX6B9A4BQRQ@mail.gmail.com>
 <20191105165556.GK30717@redhat.com>
In-Reply-To: <20191105165556.GK30717@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 5 Nov 2019 09:02:09 -0800
Message-ID: <CAKOZuet+fgaJR72YwYrHFdFVSOo6EWpcT8jUoh7se4cZb0V2aw@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 5, 2019 at 8:56 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> On Tue, Nov 05, 2019 at 08:39:26AM -0800, Daniel Colascione wrote:
> > I'm not suggesting that we fail userfaultfd(2) without CAP_SYS_PTRACE.
> > That would, as you point out, break things. I'm talking about
> > recording *whether* we had CAP_SYS_PTRACE in an internal flag in the
> > uffd context when we create the thing --- and then, at ioctl time,
> > checking that flag, not the caller's CAP_SYS_PTRACE, to see whether
> > UFFD_FEATURE_EVENT_FORK should be made available. This way, the
> > security check hinges on whether the caller *at create time* was
> > privileged.
>
> Until now it wasn't clear to me you still wanted to do the permission
> check in UFFDIO_API time, and you only intended to move the
> "measurement" of the capability to the syscall.
>
> So you're suggesting to add more kernel complexity to code pending for
> removal to achieve a theoretically more pure solution in the band-aid
> required to defer the removal of the posix-breaking read
> implementation of the uffd fork feature?

And you're suggesting making a security check work weirdly unlike most
other security checks because you hope it'll get removed one day?
Temporary solutions aren't, and if something goes into the kernel at
all, it's worth getting right. The general rule is that access checks
happen at open time. The kernel has already been bitten by UFFD
exempting itself from the normal rules (e.g., the
read(2)-makes-a-file-descriptor thing) in the name of expediency.
There shouldn't be any more exceptions.
