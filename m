Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92476159DB0
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 00:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgBKXxm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Feb 2020 18:53:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37329 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgBKXxm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Feb 2020 18:53:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id d3so121779otp.4
        for <linux-api@vger.kernel.org>; Tue, 11 Feb 2020 15:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pO1XQac3lRtY1M/28swyaSfh/76yG4K/A1KWDVLQMc=;
        b=H7/LO54HPXlaugVHdCUKWXQWNaqDJGRL9AP74RA+bD/0uYm1aIgRD9AZUMJv5rbHXO
         wa2TRAmOzpCukoY1O7GbT8ai4CWrjPZM3itJtBIsp3Nn3isaCmPTcimOh2zz+sayYYhJ
         A/CkBQVrCxAm4LLiWttL/NpJabvPU8I5ONb7moY9nbbT8qlyDkVHUdA5qm6HTF3muSjT
         EdcgHRgAbwNx/xFkJITYP94FV5vyTTADVzqHbeU8z9TOQvYPhWjTGm2cR6juMJADbRVu
         1NoyZrnwbUSziuV8uMcwwujUEXiZt5lnnObwVAKMTTAe1OIQFmSgpbUu5o1D36oy9RPz
         nNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pO1XQac3lRtY1M/28swyaSfh/76yG4K/A1KWDVLQMc=;
        b=ETYeo2mXII1drwdpBGQbQqWbruNjVNq2EbzZ8CTXzLXvJdw6ULqoXQNs5PJZ2vI4tf
         coLU4AU+zFNUX6s7we/J/ZFOswGRHvCyMU/GBtzeDGhODDTKqwU8ItPwcbMcKXCRhejB
         fz5xAyFTSXjRDxQlN1RTk+kzlvejezYeYwAj4rI9TVdgwAlXu5L+m6EMLx3oIGKzhs1F
         ut+imSWhdc6qhn8hO+B9frZIyL5qp4BfLkwgW0BWj3c2mosM8E8Sxg2OlXoZoDIrAJhz
         4MTkqzV0ApCf8Rv7lctZ5FGWEhdT93OV4Wl5eG0aIp4AV8mvaoHO2sdFPshmpTu4dyvA
         JUBw==
X-Gm-Message-State: APjAAAX80e472gHuvF7nvtmJ0WklMzA/EOpRWePkS/YbRFWzknU6OZCr
        +k6ZQeJnNHbu1auAyr466v+lP1shklSlMLWX/C8hig==
X-Google-Smtp-Source: APXvYqzsMv9hCvtLadRhB6LojTFq/xvtSEK1cMs76x7vatIdsmihFP0CQRxvF63yk9gOA14rSXjWir+Ykd+lS5oH4XY=
X-Received: by 2002:a9d:34c:: with SMTP id 70mr138640otv.174.1581465219846;
 Tue, 11 Feb 2020 15:53:39 -0800 (PST)
MIME-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com> <CAKOZuevHH1pamEKy5n5RLWDP=tHk6_9bR+g3G+HKnqm_srHvrw@mail.gmail.com>
 <CADyq12ySxau=SyyNp6VSbwmvRm6Kq1=Y62wTbQZoEAQ1XaXcuw@mail.gmail.com>
In-Reply-To: <CADyq12ySxau=SyyNp6VSbwmvRm6Kq1=Y62wTbQZoEAQ1XaXcuw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 11 Feb 2020 15:53:03 -0800
Message-ID: <CAKOZuet-vDU=p0HN5904VAmb+BpePPk77R+35cp6eQNL7fJrYg@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 11, 2020 at 3:32 PM Brian Geffon <bgeffon@google.com> wrote:
>
> Hi Daniel,
>
> > What about making the
> > left-behind mapping PROT_NONE? This way, we'll still solve the
> > address-space race in Lokesh's use case (because even a PROT_NONE
> > mapping reserves address space) but won't incur any additional commit
> > until someone calls mprotect(PROT_WRITE) on the left-behind mapping.
>
> This limits the usefulness of the feature IMO and really is too
> specific to that one use case, suppose you want to snapshot a memory
> region to disk without having to stop a thread you can
> mremap(MREMAP_DONTUNMAP) it to another location and safely write it to
> disk knowing the faulting thread will be stopped and you can handle it
> later if it was registered with userfaultfd, if we were to also change
> it to PROT_NONE that thread would see a SEGV. There are other examples
> where you can possibly use this flag instead of VM_UFFD_WP, but
> changing the protections of the mapping prevents you from being able
> to do this without a funny signal handler dance.

We seem to have identified two use cases which require contradictory
things. We can handle this with an option. Maybe the new region's
protection bits should be specified in the flags argument. The most
general API would accept any set of mmap flags to apply to the
left-behind region, but it's probably hard to squeeze that
functionality into the existing API.
