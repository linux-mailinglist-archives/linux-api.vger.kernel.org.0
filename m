Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0877625E206
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 21:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIDTjZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 15:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgIDTjY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 Sep 2020 15:39:24 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38FE4208FE
        for <linux-api@vger.kernel.org>; Fri,  4 Sep 2020 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599248364;
        bh=RmjdF/oHJi/3WsNTWPfXAZJjc7dD4QJxqtKHWGFhaY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y1o6AU6wnE4cKa2sVTMvvF98GBPa3kf10zb2k9OyNzsTlvAeCnLsXrxLX5Yl5+PsV
         DNWxaKPe/hkRRTQHxA1IrPwYyXRbq5uBF69CbAz5jm0qhHf4Wlp59wTni/lzhEHCW1
         /4dky9yz5LnF7ZO2jDJt/om5NUG2Li4Xvq7Q+c1c=
Received: by mail-wm1-f54.google.com with SMTP id z9so7429795wmk.1
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 12:39:24 -0700 (PDT)
X-Gm-Message-State: AOAM532gU76snXDbSwvIcJZWQ+gZUANPJBMrsUmpBCHnvPrVkFrzoq8c
        2pSdZ6q0er0wBPrBSvtlUR2ClslzcM0D4Ho0Q6LZtw==
X-Google-Smtp-Source: ABdhPJy6MrVLj8wN3xqE2lrca40RAAU/O1tF0PzE0euj/LnWCHYniQ59ghbEpr8F38RNHijEoqwiOEfzuzwZPhNNQmg=
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr8778079wmi.36.1599248362720;
 Fri, 04 Sep 2020 12:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200904113116.20648-1-alazar@bitdefender.com>
In-Reply-To: <20200904113116.20648-1-alazar@bitdefender.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 4 Sep 2020 12:39:10 -0700
X-Gmail-Original-Message-ID: <CALCETrVc0RCcvVhxL=x2ics-Snhh1F6o5M7EVsA2rPYcaynMyA@mail.gmail.com>
Message-ID: <CALCETrVc0RCcvVhxL=x2ics-Snhh1F6o5M7EVsA2rPYcaynMyA@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
To:     =?UTF-8?Q?Adalbert_Laz=C4=83r?= <alazar@bitdefender.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?TWloYWkgRG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 4, 2020 at 4:41 AM Adalbert Laz=C4=83r <alazar@bitdefender.com>=
 wrote:
>
> This patchset adds support for the remote mapping feature.
> Remote mapping, as its name suggests, is a means for transparent and
> zero-copy access of a remote process' address space.
> access of a remote process' address space.
>

I think this is very clever, but I find myself wondering what happens
if people start trying to abuse this by, for example, setting up a
remote mapping pointing to fun regions like userfaultfd or another
remote mapping.

I'm a little concerned that it's actually too clever and that maybe a
more straightforward solution should be investigated.  I personally
rather dislike the KVM model in which the guest address space mirrors
the host (QEMU) address space rather than being its own thing.  In
particular, the current model means that extra-special-strange
mappings like SEV-encrypted memory are required to be present in the
QEMU page tables in order for the guest to see them.

(If I had noticed that last bit before it went upstream, I would have
NAKked it.  I would still like to see it deprecated and ideally
eventually removed from the kernel.  We have absolutely no business
creating incoherent mappings like this.)

--Andy
