Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC6F159D38
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 00:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBKXcz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Feb 2020 18:32:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45496 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgBKXcz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Feb 2020 18:32:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so144519edw.12
        for <linux-api@vger.kernel.org>; Tue, 11 Feb 2020 15:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSs7UqmD5JkZZbHb6Da5Z4JrHfZRP5ftJHQt9uAAdrI=;
        b=liMR+ja4NzU1aOeqaKl4lbrBoRPtK+iwhpCD3ABdyNXC3IV0OkN3hWEOnv+stwyz0p
         dLvQVDNXNtPDaA4s61UCJ/3rotRJB/rTr5S8Cf9nj7ULYw81Aw4eW6jcW8FSnkpmkvFd
         S6jaIPrwapXw4jFnQN3EKyucf6zFOyc2+AAVH3ZF+KkhnTYbaAZHf9l69KVrBBOME6gy
         /mUhEwIhyx2yeczYKS/Ts9DFICgi9MWfVd6V5YiEbXZNoeczIP9qwGVwnFrqIrj7UhGM
         TlJlsGQhF7vrtBEFZYIULny/TaQZIx8x7GxfyVcNWvMGsS/sfcOBKF4lPCrnZ6HS/y0D
         dGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSs7UqmD5JkZZbHb6Da5Z4JrHfZRP5ftJHQt9uAAdrI=;
        b=snqYstd9NYrHIei1EulB+dMxltiEESyzp6rSoeknLJC0Vz2LhLECS5qn0AVY9zgPGA
         TgpVNoSZUNJHswlBKl2CWnS/Ddwi9ehsHO2+6j9Ngtd+ggBt7iWXR778JDhfuACwb1oJ
         fEX2myCgqVw+cUpaiTfCQz7guOCdlKwMAKRYATw9zhl35/fygPJ+MKkI38LLVViNa2rW
         ZMy8MzV2NW27kAUdgneiKJX49Ibdw6WzUiyx3/+4TmGMS+5agiMtptRaQCc5yo90uOWl
         jiziZZJG/iPwWpPzXu4f5NOBWiaOUJcsSoZyqRnQFTIYrXxSpXlPnTBVKkEIrYDhMac/
         CFlA==
X-Gm-Message-State: APjAAAVvKGXXVw+vb4nzX5VsvxDDp4nJzQp1OjPAw4LVySChudJC86Nd
        cnT5U5OMq1kdQ3sO+3fpyAjHRbH9qQaOSMpYGaGwkw==
X-Google-Smtp-Source: APXvYqwMMZEHyNax/K9vt49l37WE+90gfgIcM9+R+CCDjwgdS1qYkAJjiKABPD4lZFkil4hu37IJKAM0KZWO/WJI9NU=
X-Received: by 2002:a05:6402:6c7:: with SMTP id n7mr7881480edy.177.1581463973027;
 Tue, 11 Feb 2020 15:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com> <CAKOZuevHH1pamEKy5n5RLWDP=tHk6_9bR+g3G+HKnqm_srHvrw@mail.gmail.com>
In-Reply-To: <CAKOZuevHH1pamEKy5n5RLWDP=tHk6_9bR+g3G+HKnqm_srHvrw@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 11 Feb 2020 15:32:26 -0800
Message-ID: <CADyq12ySxau=SyyNp6VSbwmvRm6Kq1=Y62wTbQZoEAQ1XaXcuw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Daniel Colascione <dancol@google.com>
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

Hi Daniel,

> What about making the
> left-behind mapping PROT_NONE? This way, we'll still solve the
> address-space race in Lokesh's use case (because even a PROT_NONE
> mapping reserves address space) but won't incur any additional commit
> until someone calls mprotect(PROT_WRITE) on the left-behind mapping.

This limits the usefulness of the feature IMO and really is too
specific to that one use case, suppose you want to snapshot a memory
region to disk without having to stop a thread you can
mremap(MREMAP_DONTUNMAP) it to another location and safely write it to
disk knowing the faulting thread will be stopped and you can handle it
later if it was registered with userfaultfd, if we were to also change
it to PROT_NONE that thread would see a SEGV. There are other examples
where you can possibly use this flag instead of VM_UFFD_WP, but
changing the protections of the mapping prevents you from being able
to do this without a funny signal handler dance.

Brian
