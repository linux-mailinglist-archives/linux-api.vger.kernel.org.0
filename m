Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D23023310F
	for <lists+linux-api@lfdr.de>; Thu, 30 Jul 2020 13:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG3LiJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jul 2020 07:38:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22021 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726615AbgG3LiI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Jul 2020 07:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596109087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTMGVusCv/ZSTNoZER+G4z7hN5Ba3yDpH65wafBaIYE=;
        b=gacfXKzXfhivD+PBF/gggVxLBWzwaBI6VCzeuXGHi/J8cdITRB0r9CZwtnT0CSeY0bRwP7
        3wTuHg3bovKPvAiBPujmqxJ/3kIP/3DJp8ER1azz3DXIsdURJzY3N/W0bIbuXS0tBNmiX8
        a8671MSXWc2suORafVkPTNLK6XTlDzs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-o_bd53omNaG9HbBdP6IqCQ-1; Thu, 30 Jul 2020 07:38:05 -0400
X-MC-Unique: o_bd53omNaG9HbBdP6IqCQ-1
Received: by mail-qv1-f69.google.com with SMTP id u10so17824015qvj.23
        for <linux-api@vger.kernel.org>; Thu, 30 Jul 2020 04:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZTMGVusCv/ZSTNoZER+G4z7hN5Ba3yDpH65wafBaIYE=;
        b=F+dSjKC76m37SmwOqeNv/2dOGrYqZ0CTvM7oBbn1hmqwzfheXcGsmUQ8qRSJa3mYXE
         QzoM/Drev1hSjxRFhry0IbDqMy4y6lsUh+9CQHzacT9YICOTg/OYJyfUmEqt2zcK3wkt
         w773F27i3JqNiynIHl0lDjd1ge+p6cm5aE86qMrqPd0dXv5AxPI9x12XHxRaWLnxpJnf
         bikeXoRkH6EjIvZwfCEIMZaoF9O6jwz6Y0hdBsNlVrklis/wq5Wnj+6ZTR0LXn4mtU9A
         7z/SWz87q8S8346S+Tm7z+uoj8YWcvsBn29oSXzWOyiEmEFPnTPuA/jGc+xeGNUNowwz
         9/Wg==
X-Gm-Message-State: AOAM5327ec47KzbdGKAvpHYp8082wGODcStNKFqop3O+mJMjIzQh1UUo
        SYrkOUrlfte0W5E+C58ctEBW+168BshrmiGuEXRgumkD0yGNq4WcLdi8hAAeG/ClhbdQGNgyT0P
        0VHeNvL9/ned536ejp//2
X-Received: by 2002:ac8:7b9c:: with SMTP id p28mr2463077qtu.283.1596109084551;
        Thu, 30 Jul 2020 04:38:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQBR9N5/KPd8YACjNDDCygW8qxscqge6sglHY2wMjDmrqo/OXZply9Zf4IRjUryhmihi40ZQ==
X-Received: by 2002:ac8:7b9c:: with SMTP id p28mr2463056qtu.283.1596109084349;
        Thu, 30 Jul 2020 04:38:04 -0700 (PDT)
Received: from [192.168.1.16] (198-84-214-74.cpe.teksavvy.com. [198.84.214.74])
        by smtp.gmail.com with ESMTPSA id u21sm3983141qkk.1.2020.07.30.04.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 04:38:03 -0700 (PDT)
Subject: Re: [RFC PATCH] Replacing "master-slave" terminology for
 pseudoterminals
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>, enh <enh@google.com>,
        Zack Weinberg <zackw@panix.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        Linux API <linux-api@vger.kernel.org>
References: <b3b4cf95-5eaa-0b4e-34cc-1a855e7148b6@gmail.com>
 <88273c2f-ce21-db54-688d-5bebd4a81ecd@redhat.com>
 <cbf7666c-440e-b4bd-0ff6-712123845fae@gmail.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <c690ad2f-5f3c-5a8b-7b4c-ad29976aeab0@redhat.com>
Date:   Thu, 30 Jul 2020 07:38:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cbf7666c-440e-b4bd-0ff6-712123845fae@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/30/20 5:16 AM, Michael Kerrisk (man-pages) wrote:
> I know what you mean. One reason for that verbosity is the need to
> clearly distinguish "pseudoterminal device/end" from "pseudoterminal
> device pair". It's hard to avoid being wordy there.

The perfect is the enemy of the good. My feeling is that as others
write this text in emails or discussions, we'll eventually all settle
on some other short form we find agreeable and then later we can adjust
the man pages to use that. Until then taking the lead to change this
language is the correct way forward.

-- 
Cheers,
Carlos.

