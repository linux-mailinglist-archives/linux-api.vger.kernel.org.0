Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551DB351851
	for <lists+linux-api@lfdr.de>; Thu,  1 Apr 2021 19:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhDARpk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Apr 2021 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbhDARig (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Apr 2021 13:38:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D0C02FE9D
        for <linux-api@vger.kernel.org>; Thu,  1 Apr 2021 09:05:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u10so2821781lju.7
        for <linux-api@vger.kernel.org>; Thu, 01 Apr 2021 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iP5XcIUiB65F0LLqCoqPxiX0Svs4vaWqQzfjqgIZ9Cs=;
        b=FPeG12D75gTLYSxzhBVuCFWZ7afdxQScJL/saT72QoEEkvkmu4OPQw4w4cozkk1n20
         XGxo2yvy2/NQ44qtUM+WNWfgCPAl37mw1L1LrAe/r3PRY8uK8TbAN3gNKWlLrgAsry3t
         3RGscXoiWR2M5XVNZ7QurRIJZkl+KHhoU2ZaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iP5XcIUiB65F0LLqCoqPxiX0Svs4vaWqQzfjqgIZ9Cs=;
        b=XxPPZtW1NNosYeprTaM4J/TfbKtLe4HM/1ZeosgdjviKtpzEwuXp8SQCV3bgX20SNr
         TzGKouvwbSXD6ZC8ZvJcK67ptzGftTE2HZCoThlmS60z86YnKXQG7tA4nvolEe9X6s/M
         RtsXatJd0lysuDtRgEPmJ2XDQqB6gqAnWcOod7jifp6OLjTgdetGleN+sv99FaUtPTUh
         QMSQWuhno/o27t8N1c9V3EL6/FV5J/8wx/1/SJaPoTyfKnAM/oGy0jASQY61HZS0TfAe
         4aMBgIZUytTHnrfSpVNLFbXP6MQqMfWLeEYphDFlsBcv+VDIZn8oAVRI/WjobG3AMRaT
         8gJQ==
X-Gm-Message-State: AOAM533J9BLD67uyv3qTTGqIHMP7GWwp5uMnx4dMGrINegOsRL1xS6rQ
        /sNPsg6qJSQ1X6cL2K1ae3qrcIP4dykPdZEK
X-Google-Smtp-Source: ABdhPJzEFIjXJGFWRb4KleFlgCVSh3FuFlK6ASJtiLV82NsvEg6ZNYcMutpVi8EGZwaX/ZH0PxFkEQ==
X-Received: by 2002:a05:651c:1214:: with SMTP id i20mr5753991lja.423.1617293141402;
        Thu, 01 Apr 2021 09:05:41 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id p11sm582695lfr.235.2021.04.01.09.05.39
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:05:40 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id o16so2831121ljp.3
        for <linux-api@vger.kernel.org>; Thu, 01 Apr 2021 09:05:39 -0700 (PDT)
X-Received: by 2002:a05:651c:3c1:: with SMTP id f1mr5836522ljp.507.1617293139746;
 Thu, 01 Apr 2021 09:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617258892.git.osandov@fb.com> <0e7270919b461c4249557b12c7dfce0ad35af300.1617258892.git.osandov@fb.com>
In-Reply-To: <0e7270919b461c4249557b12c7dfce0ad35af300.1617258892.git.osandov@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Apr 2021 09:05:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpn=GYW=2ZNizdVdM0qGGk_iM_Ho=0eawhNaKHifSdpg@mail.gmail.com>
Message-ID: <CAHk-=wgpn=GYW=2ZNizdVdM0qGGk_iM_Ho=0eawhNaKHifSdpg@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 31, 2021 at 11:51 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> + *
> + * The recommended usage is something like the following:
> + *
> + *     if (usize > PAGE_SIZE)
> + *       return -E2BIG;

Maybe this should be more than a recommendation, and just be inside
copy_struct_from_iter(), because otherwise the "check_zeroed_user()"
call might be quite the timesink for somebody who does something
stupid.

But otherwise this new version (still) looks fine to me.

            Linus
