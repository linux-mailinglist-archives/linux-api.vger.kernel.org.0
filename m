Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF6D25E2E2
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 22:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgIDUeQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgIDUeO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 16:34:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF03CC061244
        for <linux-api@vger.kernel.org>; Fri,  4 Sep 2020 13:34:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so5239663pfh.3
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 13:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=kqY1zbvJIdcS3k1CRT2WeBjod3BmevNfAT/msz2WAyw=;
        b=1N7M5pHRondOJ1rVX5cHyTUEza0iy8R/V7/N5f3eUIcTSjl/oX6t0HcFrbp+KvjzgP
         wxs40SnVXgc3yypZlOTO8bKnzPV2NQyEY9obVObQezshwodz13tcEkpEiMCebjxJ0Qdh
         eDKJa+LHvC+E1YUs/Et0CNDPuB8/90E0qXDQsAWojm+Tb9ZHEQEPUctu0HFdFgifXL8T
         JjM6RQijruFfhA+929Cjz8QOQH/KyueoJSU2bOONkS6jYCqp7ztJmomCaz8snaiyahtn
         IsdN3/BHx+qtJDflG0dtZIHcz3SDrUCBnyE9SgYVXnklJ+7nZmeKhkzUf/0bRCUL7ynF
         9EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=kqY1zbvJIdcS3k1CRT2WeBjod3BmevNfAT/msz2WAyw=;
        b=An0oy3kwrHZf8ajYFOHjMT8edPBK0VlV6s/wuxCrnMUm9TuHlx1G60OoPRPFfI5b78
         BQt/Sy+A/reOQDcOjhNcPhtxf8ymY0wRlBIPKP2Jn8OsaCmsPP7ehVS8El5oet1UI/Sb
         F9TNQHVGGr5casP6xFps054ma414rcbZEgMA9nZXaFr1eztTyr4PAKvrrvG2UqmEQqrj
         FqsuK3NG8LHYhIc41OZAo1mLPo14qFQWqEYgNahWklMBBq36kFNS7McLBv8UOmfFJ7mO
         kSTEQx9FKZuAeql4Y7J6ai0BjA4VEpHH2ox74TQeD+OWnw6nNA6XLtH2YO9TarPMBi31
         xqcQ==
X-Gm-Message-State: AOAM5309ntfD6NKctAqhSkZjD21msPPiMkr1+/acm7iBvCw6yV4gqHR0
        Cu6+h1wMLR9lVj8GJUIwynF0wQ==
X-Google-Smtp-Source: ABdhPJxw9SbgEx6xa6sj3S0oRThNURxowXBBpD0rSQoVTxoc+yhppxHHQ5NAwGlpNRWE7etTN3m5Vw==
X-Received: by 2002:a63:2f02:: with SMTP id v2mr8483422pgv.369.1599251654135;
        Fri, 04 Sep 2020 13:34:14 -0700 (PDT)
Received: from ?IPv6:2600:1010:b003:ad53:ddbf:74c3:7dc7:4b93? ([2600:1010:b003:ad53:ddbf:74c3:7dc7:4b93])
        by smtp.gmail.com with ESMTPSA id j9sm7434354pfe.170.2020.09.04.13.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 13:34:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
From:   Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <d22e1e08-e2c1-510e-5ae7-accbf69731bf@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        =?utf-8?Q?Adalbert_Laz=C4=83r?= <alazar@bitdefender.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        =?utf-8?Q?Mihai_Don=C8=9Bu?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Date:   Fri, 4 Sep 2020 13:34:11 -0700
Message-Id: <70D23368-A24D-4A15-8FC7-FA728D102475@amacapital.net>
References: <d22e1e08-e2c1-510e-5ae7-accbf69731bf@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: iPhone Mail (17G80)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


>> On Sep 4, 2020, at 1:09 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>=20
>> =EF=BB=BFOn 04/09/20 21:39, Andy Lutomirski wrote:
>> I'm a little concerned that it's actually too clever and that maybe a
>> more straightforward solution should be investigated.  I personally
>> rather dislike the KVM model in which the guest address space mirrors
>> the host (QEMU) address space rather than being its own thing.  In
>> particular, the current model means that extra-special-strange
>> mappings like SEV-encrypted memory are required to be present in the
>> QEMU page tables in order for the guest to see them.
>> (If I had noticed that last bit before it went upstream, I would have
>> NAKked it.  I would still like to see it deprecated and ideally
>> eventually removed from the kernel.  We have absolutely no business
>> creating incoherent mappings like this.)
>=20
> NACK first and ask second, right Andy?  I see that nothing has changed
> since Alan Cox left Linux.

NACKs are negotiable.  And maybe someone can convince me that the SEV mappin=
g scheme is reasonable, but I would be surprised.

Regardless, you seem to be suggesting that you want to have enclave VMs in w=
hich the enclave can see some memory that the parent VM can=E2=80=99t see. H=
ow does this fit into the KVM mapping model?  How does this remote mapping m=
echanism help?  Do you want QEMU to have that memory mapped in its own paget=
ables?

As it stands, the way that KVM memory mappings are created seems to be conve=
nient, but it also seems to be resulting in increasing bizarre userspace map=
pings.  At what point is the right solution to decouple KVM=E2=80=99s mappin=
gs from QEMU=E2=80=99s?=
