Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B5242F98
	for <lists+linux-api@lfdr.de>; Wed, 12 Aug 2020 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHLTuv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Aug 2020 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgHLTuu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Aug 2020 15:50:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED2BC061385
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 12:50:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z14so3618540ljm.1
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0LPNTEWbU2mq6BgRpzsioeNr4RPYOF2TnDOgMD6NIs=;
        b=U1hdSpOUSLOjOrO72XqzG+q96d1pIF0cv/aZqt7kBp+fkvgL9591I+FRTAk0LrnIxR
         8JT4UZPZRO/zc5YAudhwHewQ4vDe1rgRhtOdIJf44K3wQIjkVGrwuKfqWiz5aOBB7xzw
         NmuJO1e6+UoXEurWxTmy0lrzQtpRHAgwv0Dgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0LPNTEWbU2mq6BgRpzsioeNr4RPYOF2TnDOgMD6NIs=;
        b=EOcp9q7laCAMCQggncMP6gM7i/Sw1FFIXIhTELJ+VlrzjEZrjWm3rgdl9/ntgqfXyX
         DMc1tag7dcNHUzUTm/abCxt7LJQ7+No0MDc6He/4PWk+dGquYoOCHZSipuWDPf3Ya9kK
         Uv/mSzHq+nU/Mk6kKMLJVFtawolHRC9Nq2rPNCGnfzu6PZLJv1YCO3u6xd/1LI0o+B6/
         0XUPMwQZ6RMx+QQ/skf5cOEpwBE0iFvOLrBTpet5e4aFybDdXwj+eluUZ32CU+NtfFlK
         jwGBg3CaJegvvArZkL6mYcfcXTKiYGy0lx9xTOE2nWFC/CiycM6FXlogWKQ6ptItT8Tg
         PoNA==
X-Gm-Message-State: AOAM531hWUVMflT+9NtXXE0be8JULmj6t69YsPPzQFMsHBgUhNIAwlWl
        s5q317T1P+8PKjKj+2sFPonrcTpK7sw=
X-Google-Smtp-Source: ABdhPJwf+Yelm5DcWtliLWyZv+h6izZ4Oa6xcqPBwIGshG7hghnCLGggNytCCItSAq0z77lMQGzN+Q==
X-Received: by 2002:a2e:8957:: with SMTP id b23mr344084ljk.331.1597261847859;
        Wed, 12 Aug 2020 12:50:47 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id p11sm629922ljg.17.2020.08.12.12.50.46
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 12:50:46 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id d2so1817459lfj.1
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 12:50:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr500353lfp.10.1597261845653;
 Wed, 12 Aug 2020 12:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
In-Reply-To: <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 12:50:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Message-ID: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 12, 2020 at 12:34 PM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> The point of this is to give us the ability to monitor mounts from
> userspace.

We haven't had that before, I don't see why it's suddenly such a big deal.

The notification side I understand. Polling /proc files is not the answer.

But the whole "let's design this crazy subsystem for it" seems way
overkill. I don't see anybody caring that deeply.

It really smells like "do it because we can, not because we must".

Who the hell cares about monitoring mounts at a kHz frequencies? If
this is for MIS use, you want a nice GUI and not wasting CPU time
polling.

I'm starting to ignore the pull requests from David Howells, because
by now they have had the same pattern for a couple of years now:
esoteric new interfaces that seem overdesigned for corner-cases that
I'm not seeing people clamoring for.

I need (a) proof this is actualyl something real users care about and
(b) way more open discussion and implementation from multiple parties.

Because right now it looks like a small in-cabal of a couple of people
who have wild ideas but I'm not seeing the wider use of it.

Convince me otherwise. AGAIN. This is the exact same issue I had with
the notification queues that I really wanted actual use-cases for, and
feedback from actual outside users.

I really think this is engineering for its own sake, rather than
responding to actual user concerns.

               Linus
