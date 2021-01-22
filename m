Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF072FFEDA
	for <lists+linux-api@lfdr.de>; Fri, 22 Jan 2021 09:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbhAVI6G (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Jan 2021 03:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbhAVInA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 Jan 2021 03:43:00 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B13C06174A
        for <linux-api@vger.kernel.org>; Fri, 22 Jan 2021 00:42:06 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id o18so3550251qtp.10
        for <linux-api@vger.kernel.org>; Fri, 22 Jan 2021 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IwufWQ/zvEgRChsZ+HKILdbN9V3aUSKcwTaTDvvOms8=;
        b=MdaiekH8+YWtYVJ8wdxCP2MhKco1BL/M2GSfJG3wqtKGTp9Ytszw282P+VJemlJR/I
         32ZFRGuj09mkf+Kc4c+DMAtVtsQCRw9P3STL0Ml9qZ/+FGcOC7m6k+7ff3z9c9+yz4lY
         xnat8CnLxHr+UeSrFH5Vst9nSJ6RzZ02yYd8ohDExJjPJ7M7gSIdrxW5+g9POXJq7INg
         PJM3R40ds7WtePNuEeWTo1pzwF5qOkIDYqjD6OwC1nGdfnVn1pxEViSJdFOULLJGpdPX
         uQEES2lAaHi1iXGbYqm3O8bMAsBvDvyBipOQRvgTFJG+bnN2vlvUoG4nV//9kwYAyMXV
         lgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IwufWQ/zvEgRChsZ+HKILdbN9V3aUSKcwTaTDvvOms8=;
        b=NudOpKIgTIe2lNL4jaRP5dGzick+k9eZAvA9ABylmVrHDu+8xdbbK4LjAlYaFMUUyT
         ACfyFWm9Orqsz4nlLnO7AH+AB7a+vwH7GuiqEZnsOCvfSu8zOtz25WM/hcqTQIov7Ho3
         +bL+aVSSQG8r+C/2p6ISxebM4WiBxyGwB5yshWuJIQdTuc/nAxKfV3JeUkUKQ7tkda+T
         /C4SjB2G3kIZ4lvM1LJJABXQL7MvZGAc60v1y8Vjn4msg+Y/V2cTAXQAVoxmg7jjFcke
         r4zFR0Sb5UqtNTiOOkSnKK1a5ImF6CEi2r8R8VazEQHXajsvhtzd96WnQpMhBTE9EPLc
         CQ9w==
X-Gm-Message-State: AOAM532OphU6vxLKx1diMg7Fn5dReCVFO/FxBDd9Tz/COwl3Awe/IlPt
        LxQKRcUFDnGru3tAcTEI/RLJ7DaThymfnZW97DAyIg==
X-Google-Smtp-Source: ABdhPJxapOVrvoj1KQompPgQdxxvfcXyxQBZIVC5e8ONa1BRE4MJqWv0ZyxmRs0lkc5ni4Ja3WVGNzlxjB9BJJhYTJ0=
X-Received: by 2002:ac8:6cf:: with SMTP id j15mr3284560qth.180.1611304925724;
 Fri, 22 Jan 2021 00:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20210121131915.1331302-1-glider@google.com> <YAqNoTWfp7HQ9c5m@alley>
In-Reply-To: <YAqNoTWfp7HQ9c5m@alley>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Jan 2021 09:41:54 +0100
Message-ID: <CAG_fn=WJ7QwBF67H2ND3-3n0XSZ26Xmk=Lvfwn_bpecXqq=NGQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add error_report_end tracepoint to KFENCE and KASAN
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 22, 2021 at 9:32 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2021-01-21 14:19:12, Alexander Potapenko wrote:
> > This patchset adds a tracepoint, error_repor_end, that is to be used by
> > KFENCE, KASAN, and potentially other bug detection tools, when they
> > print an error report.
> > One of the possible use cases is userspace collection of kernel error
> > reports: interested parties can subscribe to the tracing event via
> > tracefs, and get notified when an error report occurs.
> >
> > v3:
> >  - dropped the sysfs interface for log collection
> >  - dropped error_report_start tracepoint
>
> Just for record. This approach looks reasonable to me.
> Thanks for removing the sysfs interface. It would have been
> a potential can of worms.

Thanks for the input!
At least it was premature to touch prink just for the sake of
collecting some particular crashes.
Perhaps we can revisit this topic when stronger arguments arise :)

> I do not feel eligible to add any tag. I am neither familiar
> with the tracepoint nor the KFENCE or KASAN code.
>
> Best Regards,
> Petr



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
