Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A495F36F4
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfKGSYR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 13:24:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24536 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbfKGSYL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 13:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573151050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KubHtV049K2BSRPzUIF8otGa4rwY4O8d8+SI2Kib58I=;
        b=FmrpN/VLz+ZRqK4z3ZfRhTfMzJLlHhompBO4pnDMJmuyFbfN7J4Ki2DATUTTVVB3J8ZfQw
        52L1xAWPkadafntTA14NhCh3t5vtjv0rLdJWK3BQAl5a50p6X2q5qT/yR0gcq8cIbYOLtm
        zpDutWD0LM3db0hephtPnV6X1YZ1opQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-H1N7h4BROg-xZsGGE_44Kg-1; Thu, 07 Nov 2019 13:23:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE27800C61;
        Thu,  7 Nov 2019 18:23:00 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 919F9600D3;
        Thu,  7 Nov 2019 18:23:00 +0000 (UTC)
Date:   Thu, 7 Nov 2019 13:22:59 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
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
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for
 UFFD_FEATURE_EVENT_FORK
Message-ID: <20191107182259.GK17896@redhat.com>
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
 <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <20191105162424.GH30717@redhat.com>
 <CAKOZuet=g++G+biSP5bU-Rppu6fykU1TVUDj20NapqAYQY4r9A@mail.gmail.com>
 <20191107083902.GB3247@linux.ibm.com>
 <CAKOZuevhEXpMr49KmkBLEyMGsDz8WujKvOGCty8+p7cwVbmoXA@mail.gmail.com>
 <20191107153801.GF17896@redhat.com>
 <CAKOZueuKttjyRBgMkaBknzn+fzufZA+gJcd5wnKgiwmO37yN1g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKOZueuKttjyRBgMkaBknzn+fzufZA+gJcd5wnKgiwmO37yN1g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: H1N7h4BROg-xZsGGE_44Kg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 07, 2019 at 08:15:53AM -0800, Daniel Colascione wrote:
> You're already paying for bounds checking. Receiving a message via a
> datagram socket is basically the same thing as what UFFD's read is
> doing anyway.

Except it's synchronous and there are no dynamic allocations required
in uffd, while af_netlink and af_unix both all deal with queue of
events in skbs dynamically allocated.

Ultimately if we strip away the skbs for performance reasons, there
wouldn't be much code to share, so if the only benefit would be to
call recvmsg which would still be as insecure as read for the "worse"
case than suid, so I don't see the point.

And should then eventfd also become a netlink then? I mean uffd was
supposed to work like eventfd except it requires specialized events.

> Programs generally don't go calling recvmsg() on random FDs they get
> from the outside world. They do call read() on those FDs, which is why

That programs generally don't do something only means the attack is
less probable.

Programs generally aren't suid. Programs generally don't use
SCM_RIGHTS. Programs generally don't ignore the retval of
open/socket/uffd syscalls. Programs generally don't make assumptions
on the fd ID after one of those syscalls that install fds.

If all programs generally do the right thing (where the most important
is to not make assumptions on the fd IDs and to check all syscall
retvals), there was never an issue to begin with even in uffd API.

> read() having unexpected side effects is terrible.

If having unexpected side effects in read is "terrible" (i.e. I
personally prefer to use terms like terrible when there's at least
something that can be exploited in practice, not for theoretical
issues) for an SCM_RIGHTS receiving daemon, I just don't see how the
exact same unexpected (still theoretical) side effects in recvmsg with
an unexpected nested cmsg->cmsg_type =3D=3D SCM_RIGHTS message being
returned, isn't terrible too.

> If you call it with a non-empty ancillary data buffer, you know to
> react to what you get. You're *opting into* the possibility of getting
> file descriptors. Sure, it's theoretically possible that a program
> calls recvmsg on random FDs it gets from unknown sources, sees
> SCM_RIGHTS unexpectedly, and just the SCM_RIGHTS message and its FD
> payload, but that's an outright bug, while calling read() on stdin is
> no bug.

I'm not talking about stdin and suid. recvmsg might mitigate the
concern for suid (not certain, depends on the suid, if it's generally
doing what you expect most suid to be doing or not), I was talking
about the SCM_RIGHTS receiving daemon instead, the "worse" more
concerning case than the suid.

I quote below Andy's relevant email:

=3D=3D=3D=3D=3D=3D
It's worse if SCM_RIGHTS is involved.
=3D=3D=3D=3D=3D=3D

Not all software will do this after calling recvmsg:

    if (cmsg->cmsg_type =3D=3D SCM_RIGHTS) {
      /* oops we got attacked and an fd was involountarily installed
         because we received another AF_UNIX from a malicious attacker
         in control of the other end of the SCM_RIGHTS-receiving
         AF_UNIX connection instead of our expected socket family
         which doesn't even support SCM_RIGHTS so we would never have
         noticed an fd was installed after recvmsg */
    }

