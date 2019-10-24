Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8AE3E4F
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2019 23:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfJXVhJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Oct 2019 17:37:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46563 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfJXVhI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Oct 2019 17:37:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so20316556lfc.13
        for <linux-api@vger.kernel.org>; Thu, 24 Oct 2019 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5FP/voiQdxeaQU3Va8HH5cRZmi1OHTMwBKcRrrOo6E=;
        b=G+CKE+0sNMbBuosjchwhgzz8NQwfbV/8kKBYcW1zgIA+wCHZXB0W4xnrddKNkrujly
         nBXQf8TMFFxtwDaqAlubm1WQBu/DIP2jq0ClHTeKxpnxD8j4n3vqHGpl41RLHFrD0jXc
         jfdzDY5G/0JxiPvAj8Pc7cihC14c7Kl2f6hiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5FP/voiQdxeaQU3Va8HH5cRZmi1OHTMwBKcRrrOo6E=;
        b=UaHiCzARSDcknC3cHCd9EjIy59EYH5/PYUIZh1yTHEl0K1ooQe4XYb0dlhiq1Kw68k
         eUUo38seQD70bwvGDr/ts0qGgW+yKOv5kMNwkERi2zisyfR6AUPOhwh42BI9PqHcZuPW
         GFeIy3BDQkVrK/+AF3aSlH0mT4FfSmpBnO+3i88S+VzU7dolAR/zwRYhju2k5lyxCmos
         z2Uupwhdy4omBQgLpeba9kra3q9M70Hm8+VqMKm/1FoL2oomzAhJcoNfvnPad44JlHI/
         /K+tYzQecwzbzEHsTNbOzYU7Le75Pg3icD304yxJ3rG5khTZEWDpkQK16tTtK0cJJa6I
         guLQ==
X-Gm-Message-State: APjAAAX2vg+Xgm+eVm7xwRmtEj3MkJr7FVZM7ERXDwf9Z3tfx00kD0Vn
        zlMDv43pJsxDsfPOwUeGi6zSm7nzax1kzg==
X-Google-Smtp-Source: APXvYqw6VGV1RmTdrXU+xqxndOgRpbVrK7lTLFJ1k0nL2Fl6a/bPU8Swy94vjKsCsIMKqQxq+heNqA==
X-Received: by 2002:ac2:4847:: with SMTP id 7mr215010lfy.180.1571953026074;
        Thu, 24 Oct 2019 14:37:06 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id k10sm1625035lfo.76.2019.10.24.14.37.05
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 14:37:05 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q78so281818lje.5
        for <linux-api@vger.kernel.org>; Thu, 24 Oct 2019 14:37:05 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr3303284ljp.133.1571952607809;
 Thu, 24 Oct 2019 14:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <30394.1571936252@warthog.procyon.org.uk>
In-Reply-To: <30394.1571936252@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Oct 2019 17:29:51 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
Message-ID: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 24, 2019 at 12:57 PM David Howells <dhowells@redhat.com> wrote:
>
> pipe: Add fsync() support
>
> The keyrings testsuite needs the ability to wait for all the outstanding
> notifications in the queue to have been processed so that it can then go
> through them to find out whether the notifications it expected have been
> emitted.

Can't you just do

    ioctl(fd, FIONREAD, &count);

in a loop instead? "No paperwork. Just sprinkle some msleep() crack on
him, and let's get out of here"

               Linus
