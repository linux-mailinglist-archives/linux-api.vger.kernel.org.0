Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118C314AC14
	for <lists+linux-api@lfdr.de>; Mon, 27 Jan 2020 23:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgA0WeN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Jan 2020 17:34:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37597 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgA0WeN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Jan 2020 17:34:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id cy15so12551880edb.4
        for <linux-api@vger.kernel.org>; Mon, 27 Jan 2020 14:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kff3NaTIW20pZaIb7KyxUJFhaAL5rAMZfCM5Cj65zKM=;
        b=dcLteYXiqYKv1WHOfAf3rVdpBgqxKWRTBbFSxrhkjtAhJbBCOCLiGTfDsPDZAi8LwC
         2AlOgUZE1lvmQD84XRv7w8X6Q0fyRWRV/Cr/DQO6InEO6DxpG74ofsdekO9AUoaR7Q38
         TevVCE+WIuIW1MZ7d7pobTPFJInrlnLMpck69eAslrW4w7H1YQ5dnPfDbu9I1yFJY3Bx
         xWx8LMkrbrUUGpZ7dL64goyfLvVorGd0cWhoVksTwXSl0bdlwtQHn+Hc+PHeZ9xyM05q
         /NNShn9u9FWtC9htX0mxN0sIjHpuSSXJRalIXygXSAGAS5EDjOyFkIrJP26E8zOUU29A
         aVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kff3NaTIW20pZaIb7KyxUJFhaAL5rAMZfCM5Cj65zKM=;
        b=eJMZIB70XQvng9XBxFSrwSCFstGK6Mk5+4kaLvWTJ2BQyQeTsULWw+kuWjggT/tvkS
         q+ccF6ncQAkTkzNz8BYVe9xxdfDepelFK9ml6Qjl92tpI4SnK+sV9+4Wibswzxzm3Mjw
         vcP/DCUF8A0TdGete7qUunuip2ZYNXNQPSydxxMUgjq/HaWQxH66bQsIfe5I2Oj0S+j+
         ELorBUIJCPa5O6YQ6rv2NCTXsmxQ+/PsaMw2qxGx0ygKs7VmsUknQDGcETZnxjho0Hfw
         wLGyIPL+X8YyeG0F0oq7lTGA8s9NeGaavCZQuNErDozDZCN6l0IcuEl6os2VFV7IaWUo
         WlgQ==
X-Gm-Message-State: APjAAAUyAcRD4acLPGI+kRZFui1IVOwrjhNk0j5edpp6sow2tfP2voyw
        RK8RX5elGrAWB0XwmhaNm8F4fLH5ai6OBYNPH8biJw==
X-Google-Smtp-Source: APXvYqxmihDvQKDeTJwEWMIPBNcI86K1DIY4nnX7rUdDLp5/wdi7JNyrCrSTzwqnb4lvmla3Q4N4MNmCF2g2v7VE8NQ=
X-Received: by 2002:aa7:c445:: with SMTP id n5mr893840edr.346.1580164450645;
 Mon, 27 Jan 2020 14:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com> <20200124190625.257659-1-bgeffon@google.com>
 <87imkxxl5d.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87imkxxl5d.fsf@oldenburg2.str.redhat.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 27 Jan 2020 14:33:44 -0800
Message-ID: <CADyq12xCpTzLpYC16FjnM60tHhCfnccNfg6JJuqcBd_6ACDGcQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Florian,
copy_vma will make a copy of the existing VMA leaving the old VMA
unchanged, so the source keeps its existing protections, this is what
makes it very useful along with userfaultfd.

Thanks,
Brian


On Mon, Jan 27, 2020 at 2:13 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Brian Geffon:
>
> > When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> > set, the source mapping will not be removed. Instead it will be
> > cleared as if a brand new anonymous, private mapping had been created
> > atomically as part of the mremap() call.  If a userfaultfd was watching
> > the source, it will continue to watch the new mapping.  For a mapping
> > that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> > mremap() call to fail. MREMAP_DONTUNMAP implies that MREMAP_FIXED is
> > also used. The final result is two equally sized VMAs where the
> > destination contains the PTEs of the source.
>
> What will be the protection flags of the source mapping?  Will they
> remain unchanged?  Or PROT_NONE?
>
> Thanks,
> Florian
>
