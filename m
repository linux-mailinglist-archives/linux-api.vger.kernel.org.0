Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E53925E28E
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 22:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgIDUSZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 16:18:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31233 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726441AbgIDUSY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 16:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599250702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ur9HpmZf28TON8CHWc9+9TwgcC5lgzfKgaHYfzgcxs=;
        b=FlgYTkMGOL2hkq/k2smX5e/X+/EVY2vdO6YzVp9lJOGVv9qZTSMgGLQV8GfmYBCLvAk/5Z
        SYhxjj/kGAcU4kmHpLSK8a+QnxyKRx6QlKbfD/yNl0/Ps31BYb++J+3IIZa4ONYLmL0vXH
        8dCJPu10LNGWjKNsyWVvdDyntKXWbWw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-TPIY3L6AMdS5WV-eCFSpaA-1; Fri, 04 Sep 2020 16:18:20 -0400
X-MC-Unique: TPIY3L6AMdS5WV-eCFSpaA-1
Received: by mail-ed1-f69.google.com with SMTP id b12so3133198edw.15
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 13:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ur9HpmZf28TON8CHWc9+9TwgcC5lgzfKgaHYfzgcxs=;
        b=pDZBx62Ma1BmEUPW9Oq+uSda32ftrn+xp0Gm99AE49d7mHYreHT9Sz0F/Uh/IzFScP
         6RiaTqN9lBteRsrXKCKg6Cocl3hyksreht3SIeB+cPq+EB09pao2q6JZ9c08RPjDtwcg
         7ZOH1FStu8yZ7WBgCY/xoCn9tWrMfJqfNCBPEjUZATymvAe80V+gAL3VCIB/WR2GVRHV
         ehj2SB8g9ovxuO+nvqoYWCXQtSj8PHapyjhgGo+RvFtlgXajn1b8rZtvqhAD1ln8bsQw
         398C4qOAfvuHk4YttBga1fKAVpEULl8Z9I11zbaQ/bLmHoj11UpiRdFvXrhS4zjaySRe
         jKCA==
X-Gm-Message-State: AOAM5304XLE/bG94D1C6MwEzqH0ye5Hv+bgM6n/mjbmhpgpotXSkNFlZ
        MkblGkSMtmK5T/Me/CfVgu0gO2vkI0yExolWk3zlWi1t8uumm8xcFeOuN4Z0jRKK8ckEDNDvR/F
        2XmwSQPjy52Ml374D5TOR
X-Received: by 2002:a17:906:b154:: with SMTP id bt20mr9625634ejb.272.1599250699549;
        Fri, 04 Sep 2020 13:18:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Ggiccs73r/w622i0UNJHJe4gtmawevHQ5W9SQCuqBXAXICrfKwM/er78OQ+xfgsFYnvaOA==
X-Received: by 2002:a17:906:b154:: with SMTP id bt20mr9625611ejb.272.1599250699359;
        Fri, 04 Sep 2020 13:18:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6276:52ed:96d5:c094? ([2001:b07:6468:f312:6276:52ed:96d5:c094])
        by smtp.gmail.com with ESMTPSA id ci27sm7276701ejc.23.2020.09.04.13.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 13:18:18 -0700 (PDT)
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
To:     Florian Weimer <fw@deneb.enyo.de>,
        =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <87pn71gxi8.fsf@mid.deneb.enyo.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5447a405-4e4f-8034-eb86-ec2f6ddf45f0@redhat.com>
Date:   Fri, 4 Sep 2020 22:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87pn71gxi8.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 04/09/20 21:19, Florian Weimer wrote:
> I'm not sure what the advantage is of returning separate file
> descriptors, and nit operating directly on the pidfd.

For privilege separation.  So far, the common case of pidfd operations
has been that whoever possesses a pidfd has "power" over the target
process.  Here however we also want to cover the case where one
privileged process wants to set up and manage a memory range for
multiple children.  The privilege process can do so by passing the
access file descriptor via SCM_RIGHTS.

We also want different children to have visibility over different
ranges, which is why there are multiple control fds rather than using
the pidfd itself as control fd.  You could have the map/unmap/lock ioctl
on the pidfd itself and the access fd as an argument of the ioctl, but
it seems cleaner to represent the pidfd-mem control capability as its
own file descriptor.

Paolo

