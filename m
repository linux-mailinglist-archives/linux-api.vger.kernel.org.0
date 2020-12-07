Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500042D170B
	for <lists+linux-api@lfdr.de>; Mon,  7 Dec 2020 18:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgLGRA4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Dec 2020 12:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGRA4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Dec 2020 12:00:56 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F4EC061749
        for <linux-api@vger.kernel.org>; Mon,  7 Dec 2020 09:00:15 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so10615510pfu.1
        for <linux-api@vger.kernel.org>; Mon, 07 Dec 2020 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QnGr2uLlRVv0Kp0z/5mvUiJcUu+l6BwGXi6XzETAWIk=;
        b=ni2I3dzwrj+2nOh7Nejc4hzR+if+2mdHCZbEsmiTx1SH5b1gsi6KhuPPiKRtO7I0KA
         pszRUkz/H4XaCskROhszynqzxv1XBtyP5ywDwK5Lucd6FkD8sMpM/3hmujTlyOo7VOAb
         7O8tnuqErHWiVIIoSfmMjk5EJRuISo5flY1qxf3Z0m+Nn/3ikk9el5G5MmKz2DXsAB5c
         OdFU+qkw5nkchSqvKhHaiY7b7QGzT1A7Cw5cF+x/si7JwDTL+qKdjaXv3ZFhwckeA3Gh
         RvrqqUec8i70z/pGhqZ+61fpl5TP9u6QgC1mGzyaKcrCB455qcTQj5h/jYodrkTiCQSD
         aAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QnGr2uLlRVv0Kp0z/5mvUiJcUu+l6BwGXi6XzETAWIk=;
        b=QI8oGViMFjqEZ1iWzx0PSZ/AdjCi2TqcNpCsfDz3XbLgjLYmg1R/ISys3FcIyAZOHb
         IXFZ8oWKzpWlqLY8ofHlq1Cio6C02MUwVRZOC3WJvdI0avb3fEm82NUuNhrpPHTgHxUD
         UR7X8NG/paUeunQ/22A/RQUZ2nJcECX7hwFxIPGRWD3hbkLG0s6WaM0oGhCCToq23gkc
         3nb4uZu8AhgUxl16QhTszOrom2PJ3NU2Kk6XW4rf4JapzSYJhB3SGgGT1fXRoNj6K2ar
         +sz4iQR2wox66yoD9MevtRGg000iAfqaP28+bLwbnG8IVwUudJrp99TyADP7RvFh+oW0
         Rs0A==
X-Gm-Message-State: AOAM530pdUecpVur1J5zmqKaaMU/dFiIj9pl6PEJ0xGgdeG/UWtkEH8V
        SWix/CkG+wVOWqzQwjhymUl7Lg==
X-Google-Smtp-Source: ABdhPJwfeAgrb/a5NezGX9uvGgxdsm1irH0aEO5frU+Xkugn3eGP7exs+nWQTO+OAtxVzoSeupF+Wg==
X-Received: by 2002:a05:6a00:885:b029:19b:9057:16f with SMTP id q5-20020a056a000885b029019b9057016fmr16433948pfj.80.1607360414808;
        Mon, 07 Dec 2020 09:00:14 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:799e:e3fc:86a:de72? ([2601:646:c200:1ef2:799e:e3fc:86a:de72])
        by smtp.gmail.com with ESMTPSA id 125sm15150483pfy.111.2020.12.07.09.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 09:00:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC net-next af_unix v1 0/1] Allow delivery of SIGURG on AF_UNIX streams socket
Date:   Mon, 7 Dec 2020 09:00:12 -0800
Message-Id: <8A94EE38-C4F4-4EBE-9737-D331AD34274A@amacapital.net>
References: <20201207163520.GA7494@casper.infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, rao.shoaib@oracle.com,
        Christoph Hellwig <hch@lst.de>,
        Paolo Abeni <pabeni@redhat.com>, jbi.octave@gmail.com,
        Linux API <linux-api@vger.kernel.org>
In-Reply-To: <20201207163520.GA7494@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Dec 7, 2020, at 8:35 AM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> =EF=BB=BFOn Sat, Nov 28, 2020 at 08:02:37PM -0800, Andy Lutomirski wrote:
>>> On Sat, Nov 28, 2020 at 7:07 PM <rao.shoaib@oracle.com> wrote:
>>> We have a use case where thousands of processes connect locally to a
>>> database and issue queries that are serviced by a pool of threads.
>>> Communication is done over AF_UNIX sockets. Currently, there is no way
>>> for the submitter to signal the servicing thread about an urgent
>>> condition such as abandoning the query.
>>=20
>> Sure there is.  You could close() the socket.  You could send() a
>> message saying that your query wants to be canceled.  You could use a
>> second socket for this if it's somehow inconvenient to do it with a
>> single socket.
>=20
> The application already works with SIGURG (and TCP, obviously).  Yes,
> it could be changed to use one of these other methods, but they're all
> more inconvenient to use than SIGURG.
>=20
>>> This patch addresses that
>>> requirement by adding support for MSG_OOB flag for AF_UNIX sockets.
>>> On receipt of such a flag, the kernel sends a SIGURG to the peer.
>>=20
>> SIGURG is a horrible interface.  It doesn't scale -- signals are slow,
>> and they give no indication of *which* socket has urgent data.
>=20
> It doesn't need to scale.  This is "client wishes to abort the operation",=

> just like telnet.  Each thread only has one socket (and, thanks to
> F_SETOWN_EX, signals for that socket get directed to that thread).
>=20

Oh, you have thousands of clients and each client has its own server thread.=
 Lovely.

>> Aside
>> from this, the "urgent" interface itself is nuts -- even the TCP RFCs
>> and implementations seem unable to agree on exactly how to tell
>> *which* data is urgent.
>=20
> That doesn't matter.  Unix sockets with MSG_OOB behave like they
> have had SO_OOBINLINE which is the recommendation from
> https://tools.ietf.org/html/rfc6093

Fair enough.

>=20
>> At least epoll might be a scalable way to
>> tell which socket has urgent data, but that's not what your patch
>> description seems to be talking about.
>=20
> epoll is the wrong interface for this application, as far as I can tell.
>=20
>> Oh yeah, SIGURG simply doesn't work across privilege boundaries.
>=20
> Please elaborate.  SIGURG is default-ignore, so you have to enable a
> handler for it.  And you have to call SETOWN to receive a signal.
>=20
>> I'm also a bit nervous that there might be some program out there that
>> expects SIGIO but not SIGURG on unix sockets, and you're breaking
>> them.
>=20
> The only incompatible scenario I've been able to think of is an
> application which has both TCP and Unix sockets will suddenly get its
> SIGURG handler called for Unix sockets when it's only expecting to get
> it called for TCP sockets.  That feels like a very unlikely scenario.

So maybe this is okay. It does seem like a hack, but maybe it=E2=80=99s a ha=
ck that=E2=80=99s not too bad to support in the kernel.=
