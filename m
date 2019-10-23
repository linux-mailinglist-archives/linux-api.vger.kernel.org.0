Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62150E26CF
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2019 01:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404236AbfJWXB5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 19:01:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36764 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732651AbfJWXB5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 19:01:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23so13017321pgk.3
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 16:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Qor75HOdV9osJzTRx0zqKlc/1Orw2uFvi+ewxkXrpvA=;
        b=trlLMKAG64sqHo+sIqkb1vJf6fpSVvBp1Nf1tIXyRCr4FE3M6AviSLMEeFmlU4xEX2
         HwvpMSndt82ykYw5PbbVHx8es0J1sunCmpRr3DfVt8HKKMJJJq7FyaOn2guS359vlq9v
         N+7aFRQD7bC5iWToWtajzNpZevPbPTBeJPsXy8XnVsmr++Fqur+K+82RQJ/MyZGcJ6l2
         0dtAw04WYyU0fN7UGUWyQzzkVl0M5BIJR3pJ57HAbSe7udvxeLUa9ZCsMlyhrNj5/KLB
         HAAhfyftd0eyYbAYKySaJ4Ezf7tdfT6bp8Ep57aYRfq6SaGD2j48WLaY48U7wN+TA58U
         w5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Qor75HOdV9osJzTRx0zqKlc/1Orw2uFvi+ewxkXrpvA=;
        b=dyhSoIjQOutqPxtsQgQqdhvTI5f0oBt6sw7n/eP2EvWmT9AF5PG4LlF9GwTJVEWuu1
         7MVE0Y7QvBTbXIOCovFt1SVeJ1op/6OdEDPj5x1FkqTduR3jE+BKvUILLIUCtywm8Fsk
         0OIJhU9Krk/xGLO9NtqjLS2M3LmaEsoLhhY1RDjntE+IDU0zVnpJMaxIGUET00GqH6M6
         /OFlEXDhDpCeyvsyeeD9gwmTEzrwRFT96/XOrGVFleFyz/bi59beQpQiGspnUmp15R6n
         WLa3hjrKinlZ/yD0RIFByWfzkUY1DlKdrviZHBaa+6+cO9sVNhAqhb82uPUcCYjxtdoQ
         xy8g==
X-Gm-Message-State: APjAAAUvwVi8NvN0g4NeYa1pPlmJVY/tz3rIKpE9hL1BjQ3tlXm9PEmn
        7KkmM/E1KujyfyvVJdOxGNqt8A==
X-Google-Smtp-Source: APXvYqyXx2MCeXU1TRxcpLTChxtVx5COXTgAX6PiGM+/u8U1irQhW/OrNxr7KE0YDnE5NQk7fzqm/w==
X-Received: by 2002:a62:7d57:: with SMTP id y84mr14158828pfc.90.1571871716495;
        Wed, 23 Oct 2019 16:01:56 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02e:424b:3981:2a2f:eca2:3b9c? ([2600:1010:b02e:424b:3981:2a2f:eca2:3b9c])
        by smtp.gmail.com with ESMTPSA id r185sm25541445pfr.68.2019.10.23.16.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 16:01:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
Date:   Wed, 23 Oct 2019 16:01:53 -0700
Message-Id: <EB0634BD-AAF4-4805-8178-30FFA94B7B58@amacapital.net>
References: <20191023224110.GE9902@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
In-Reply-To: <20191023224110.GE9902@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Oct 23, 2019, at 3:41 PM, Andrea Arcangeli <aarcange@redhat.com> wrote:=

>=20
> =EF=BB=BFOn Wed, Oct 23, 2019 at 02:25:35PM -0700, Andy Lutomirski wrote:
>> That doesn't solve the problem.  With your time machine, you should
>=20
> Would you elaborate what problem remains if execve closes all uffd
> so that read() cannot run post execve?
>=20

fcntl() can clear the CLOEXEC flag. And CLOEXEC has no effect on SCM_RIGHTS.=


>> instead use ioctl() or recvmsg().
>=20
> The event delivery is modeled after eventfd.c per userfaultfd.c header
> file, so would then eventfd also need to be converted to ioctl or
> recvmsg to deliver its event any better? Initially I evaluated to use
> eventfd for it in fact, but it wasn't possible. I didn't look like it
> could get any better than eventfd in terms of event delivery.
>=20
> Or do you refer to single out only the delivery of the UFFD_EVENT_FORK
> event not through read()?

Delivering events through read() is just fine. The problem is when deliverin=
g an event does more than just returning bytes. As far as I=E2=80=99ve notic=
ed, uffd=E2=80=99s read() just returns bytes as long as FORK is disabled.
