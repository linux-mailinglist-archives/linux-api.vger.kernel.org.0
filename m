Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F91F29E2
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 09:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfKGIzi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 03:55:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44519 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733117AbfKGIzi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 03:55:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id v4so943867lfd.11
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 00:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWZb6GLCF2st+ZVn+OJmwleeG1odyNOnzVdWxMN71m4=;
        b=k2Zi5ilUpvfwvkE4Ppxa+x0nf4km4BOuvWm1ykPz7BHyrgqo9vEkTpio3e+6YeSAiA
         ksg0hvGFAxJJ5+A1qVHYbExIOTneSQo46Sclk8UiCKSz3NT2s4jWy4p2tAEvwQrmNNiU
         R1dMTOqkY/lBDgJo9yps5cz+dnI+fVkq6IK2r1jtC5lneKbhlws47UcUOwdRPKltMqm6
         zij//x+VBfeyEyoCWdveF8tUyAQEZ/iEK//xFdiRYEFxUGp0LG7WkmOsphoK1smcLmLN
         NJv5g+5Rf59q8D3VZyo4H3tIiMq2sFCIea6ZVnCBi3GTqfgWNkPBXG3iEIDBsP1axhe2
         e4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWZb6GLCF2st+ZVn+OJmwleeG1odyNOnzVdWxMN71m4=;
        b=l6CSKh5ra44zp8rGfPEqiCRxEDxdZU50P2in9nYzMg92vClMys4sm86GCANl2L4q9J
         ntq2sfbQzFHpXgzUeh3RokNe1PnMj2e7geTwOJrK1Me8Vq7VQL/cby2nfiiMoYBBh+Y+
         1BvEwQAQRdR7BHXdjAy2CvBVF2hxd5GDV1kU4aPOSkpe/P6PLa6XDPd+QEn9wjAx2wi9
         2nyhjIzTxISYE58Wu7qUM8JXBZTO7kJNPqyj6LQQFo91YcjL0ABLVFkqOX4AN/4CNKMr
         Lxedjls3oLFChHJ2Y2IY7V5SWOg8Yr5kOmM/1ZaBn2biPs2Lxm8s2wMltjcY3gYbv6Uy
         HgWw==
X-Gm-Message-State: APjAAAVRY0sLRGP8ED4ePVTUovdvNcW4R366aUGRyZWHq74lKtbNMvMP
        zBIgAWD5Z3TN5fGEvmdVNZIyINf1Fc0VJDY/BLCs7w==
X-Google-Smtp-Source: APXvYqwjmdL6xPlKTj58mFSrRkwb7zeLwRzSWb8Xgzdfaw5gPK5uHdRZEynEOzKUFWJ8jFmyiGAvxtKcJWxmRt9gblQ=
X-Received: by 2002:a19:8582:: with SMTP id h124mr1571095lfd.64.1573116935696;
 Thu, 07 Nov 2019 00:55:35 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <20191105162424.GH30717@redhat.com> <CAKOZuet=g++G+biSP5bU-Rppu6fykU1TVUDj20NapqAYQY4r9A@mail.gmail.com>
 <20191107083902.GB3247@linux.ibm.com>
In-Reply-To: <20191107083902.GB3247@linux.ibm.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 7 Nov 2019 00:54:59 -0800
Message-ID: <CAKOZuevhEXpMr49KmkBLEyMGsDz8WujKvOGCty8+p7cwVbmoXA@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
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

On Thu, Nov 7, 2019 at 12:39 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> On Tue, Nov 05, 2019 at 08:41:18AM -0800, Daniel Colascione wrote:
> > On Tue, Nov 5, 2019 at 8:24 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
> > > The long term plan is to introduce UFFD_FEATURE_EVENT_FORK2 feature
> > > flag that uses the ioctl to receive the child uffd, it'll consume more
> > > CPU, but it wouldn't require the PTRACE privilege anymore.
> >
> > Why not just have callers retrieve FDs using recvmsg? This way, you
> > retrieve the message packet and the file descriptor at the same time
> > and you don't need any appreciable extra CPU use.
>
> I don't follow you here. Can you elaborate on how recvmsg would be used in
> this case?

Imagine an AF_UNIX SOCK_DGRAM socket. You call recvmsg(). You get a
blob of regular data along with some ancillary data. The ancillary
data may include some file descriptors or it may not. Isn't the UFFD
message model the same thing? You'd call recvmsg() on a UFFD and get
back a uffd_msg data structure. If that uffd_msg came with file
descriptors, these descriptors would be in ancillary data. If you
didn't reserve enough space for the message or enough space for its
ancillary data, the recvmsg() call would fail cleanly with MSG_TRUNC
or MSG_CTRUNC.

The nice thing about using recvmsg() for this purpose is that there's
tons of existing code for dealing with recvmsg()'s calling convention
and its ancillary data. You can, for example, use recvmsg out of the
box in a Python script. You could make an ioctl that also returned a
data blob plus some optional file descriptors, but if recvmsg already
does exactly that job and it's well-understood, why not just reuse the
recvmsg interface?

How practical is it to actually support recvmsg without being a
socket? How hard would it be to just become a socket? I don't know. My
point is only that *from a userspace API* point of view, recvmsg()
seems ideal.
