Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8C25E266
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 22:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgIDUJR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 16:09:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42875 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726618AbgIDUJQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 16:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599250155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YtjkCDBznio4EFWycuRl0XTCwzQwRh7Zk8qEDyaA+R8=;
        b=SkHB3LF1u3YG69b65ZrXrV5o+cXjx88x1KeHVSxn+qrqrrn9ZCO8BbeV1oYV3Quaj2JVHZ
        K8RdZtiT3CZXfIO7stHuwW+UfF40LeBIOQBFDtsMra2CxHUeQ9qCZThSYrIkIenSrUm3Hr
        wM+w2EWSSAooLWE+wBwRSLwyVLs6Pn8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-AH7wONrrPxObzaVD5RxhkA-1; Fri, 04 Sep 2020 16:09:14 -0400
X-MC-Unique: AH7wONrrPxObzaVD5RxhkA-1
Received: by mail-ej1-f70.google.com with SMTP id lx11so1197692ejb.19
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 13:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YtjkCDBznio4EFWycuRl0XTCwzQwRh7Zk8qEDyaA+R8=;
        b=Y812j6R6HbNAuDcTG8u/t+Mc/+Typ+wQVJ0ZFpV+ZbZYXLkRB1xsfvhHJXnMf4ofdv
         skluo2LmZbv7OPhGkdfgrp8KTZI945F29cM4Yzyx1m1NL4flH5B2JOz3pigoY4Wu1D/+
         UDPRq6ZIOOSKpDL8e6pufq6dTCBzWIn2MoA52AA70QN9ZCq6/SN02Gf9ll4hDuB5A5au
         h905RzQa0Im5UhxDTW6hV0zbkb2Dfke6pa+gH9LA3WZfdDRhEJ7CA+18lePZYJ9aJuP2
         ZlFX9vQY3QjB3xq4Bj7dtnBZjX0R3wwM3A8Bl4wh0du2YMz9JqLbQgqBl6Rt7QpHuPGu
         SJhw==
X-Gm-Message-State: AOAM5330VRVeBvdjhUwmFXUKIIqtx5BzsFYyxqC8stxrIm99qGInnrFj
        bv2E0HU6PbXEi2Q88lxMUxWD/tzrmYAK+yoR9xeCJIv25rUgRf/eDi0LoghzlWkSENEpKxqMMnY
        W1xTYbXFlKEzZIy9QftPQ
X-Received: by 2002:a05:6402:1697:: with SMTP id a23mr10639654edv.195.1599250152834;
        Fri, 04 Sep 2020 13:09:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX4Xhh11LgQlC31ujeG/EeQSnZyvInjG7xGIKM954pWhZp/ItPYfvo3YIfvnGUyMHrRxxzsg==
X-Received: by 2002:a05:6402:1697:: with SMTP id a23mr10639629edv.195.1599250152631;
        Fri, 04 Sep 2020 13:09:12 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id bq24sm7048032ejb.27.2020.09.04.13.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 13:09:11 -0700 (PDT)
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
To:     Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <CALCETrVc0RCcvVhxL=x2ics-Snhh1F6o5M7EVsA2rPYcaynMyA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d22e1e08-e2c1-510e-5ae7-accbf69731bf@redhat.com>
Date:   Fri, 4 Sep 2020 22:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVc0RCcvVhxL=x2ics-Snhh1F6o5M7EVsA2rPYcaynMyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 04/09/20 21:39, Andy Lutomirski wrote:
> I'm a little concerned that it's actually too clever and that maybe a
> more straightforward solution should be investigated.  I personally
> rather dislike the KVM model in which the guest address space mirrors
> the host (QEMU) address space rather than being its own thing.  In
> particular, the current model means that extra-special-strange
> mappings like SEV-encrypted memory are required to be present in the
> QEMU page tables in order for the guest to see them.
> 
> (If I had noticed that last bit before it went upstream, I would have
> NAKked it.  I would still like to see it deprecated and ideally
> eventually removed from the kernel.  We have absolutely no business
> creating incoherent mappings like this.)

NACK first and ask second, right Andy?  I see that nothing has changed
since Alan Cox left Linux.

Paolo

