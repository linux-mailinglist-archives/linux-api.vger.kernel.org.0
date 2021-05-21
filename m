Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8BA38CA8A
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 18:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhEUQEs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhEUQEq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 12:04:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39485C0613CE
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 09:03:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i22so30258171lfl.10
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yiSHm/i0ntIC7XV9xeKxtIeUyYju4T+JD0ZeRfIjKFo=;
        b=pqRuS9toNOMN69IxAEDNhxeuDceaDJikh7Bd9vsb5rOXAkMuzb6Lp0xwKixYtSucz4
         On6UNZ4deHHb1i0M3LzSaYQfA7kIvKWCB99LZx92cM0p+krKQ8Zokd4uiwEMhz3Cn1MV
         zzBh3tP35+2CiLcY/YR3pXRE1+ICooRpQMA7HewKmDPH2aMnxJS7hDdieFteC4gnxEbG
         TBCpDqjgzCjBi/dYIq4geI4rUyZS+Bkv5g06oMAH+mzcoN73Xh56oIIsXuscPPOuRM2H
         Xvviqoq1CQGRCmrGvLcEoJhzjFpKBwaIZJODSWnVX0w72c9HyhCJ8sn1+qFynfamm0jD
         EZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiSHm/i0ntIC7XV9xeKxtIeUyYju4T+JD0ZeRfIjKFo=;
        b=mxq0IA7WkS7+Ig/rssXL7/oO123/qoy9BYm4TdMR9FcdtA8pvYFEUPW+QMVNPnHxF+
         6dILIpU7EfrE948NETUj/zwXS/QrkfINgiSHROboQHvMK/SdmJrjC2X8wqg3u+FJu/0E
         8Frm/x4Fs43cD6ovewAgd20GgWrb9h1Ey9vscu9dsthdSKBTZogQy2xcoQq14tm+irwY
         aa3oYAG3qQOll4H1hCsYdQLVk3zJO80cCS20JexNw1Ya/e5HeW3bhUM7lREr0W/VVCNj
         /4dzuNiJ/yg1u174g1cDA96frw0puLGUtsSSvfZmN32TVceVDRniCThchFjn6C0ibLN2
         O9uA==
X-Gm-Message-State: AOAM533wRF4c3RnQKk411fLPpy5p6kyjkL7eZGjOHPazNiEqWT8tjjsb
        eaNCVV+wdACamdu3nq8NJF7n4cVABPO4lpzvMGbJUQ==
X-Google-Smtp-Source: ABdhPJxXq0B6Vn9HMEOppK94x/UHgrXEDhu0rEkT2EJkihbrQyKoQ2ii57nIv7CFq4aUMptuOh6rwPZwTt1/EL3b/+U=
X-Received: by 2002:ac2:520a:: with SMTP id a10mr2710768lfl.180.1621612999247;
 Fri, 21 May 2021 09:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <87mtspm7fe.fsf@meer.lwn.net>
 <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com> <87eee0m8ez.fsf@meer.lwn.net>
In-Reply-To: <87eee0m8ez.fsf@meer.lwn.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 21 May 2021 09:03:07 -0700
Message-ID: <CAPNVh5fhkgscs44Lpj3DPBrA9NrhFohUpRwpT2iMM1BDBcLW4A@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21, 2021 at 8:08 AM Jonathan Corbet <corbet@lwn.net> wrote:

[...]
> Documentation patches can help to guide that discussion; they also need
> to be reviewed as well.  So yes, I think they should be present from the
> beginning.  But then, that's the position I'm supposed to take :)  This
> is a big change to the kernel's system-call API, I don't think that
> there can be a proper discussion of that without a description of what
> you're trying to do.

Hi Jon,

There are doc comments in patches 2 and 7 in umcg.c documenting the
new syscalls. That said, I'll prepare a separate doc patch - I guess
I'll add Documentation/scheduler/umcg.rst, unless you tell me there is
a better place to do that. ETA mid-to-late next week.

Thanks,
Peter
