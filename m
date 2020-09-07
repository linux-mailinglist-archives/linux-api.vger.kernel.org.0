Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08A25F58F
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgIGIoW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 04:44:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59500 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726978AbgIGIoV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Sep 2020 04:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599468260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aaOnnZavIi0qQx0ODHr2L7J0eT2qjJXTuehNnwmVlr0=;
        b=gs0+EazShwpp2nehRwZOxc3/0/UIcFmsEoLZRE1gyArCvTFOB5NTvqlZQKr7pk/YlOOH/N
        19A+HoosufudXGKoG87As62bOF2rzDOMsE6gIb49F9ieEMbREHsv7VBAvH5DIQ5hAPUoWb
        9kdtBI0c8xXMtZ6idy60xIIVo7OH55E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-oSEhGyczOMCaRWIzSZoEaQ-1; Mon, 07 Sep 2020 04:44:19 -0400
X-MC-Unique: oSEhGyczOMCaRWIzSZoEaQ-1
Received: by mail-wr1-f71.google.com with SMTP id b7so5463072wrn.6
        for <linux-api@vger.kernel.org>; Mon, 07 Sep 2020 01:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aaOnnZavIi0qQx0ODHr2L7J0eT2qjJXTuehNnwmVlr0=;
        b=Dv7W5UqJxwr3VD64Xqcbdk3b4c4IKNb9YTS7wLqy+XCMICypIX9azX+XgB/LI62n1D
         gj8kfZj5zZQcdP4xWL9IKapDPCf/tSzdJqW9Ak4GmVVYCKuiPGWCNNWrHiIvBsYlarqs
         7eQxkJDpaLotAf31YiEjYCppvpCToR6knkLdAXLtOxLaNe0y6Axnp6zNR9aAotEBY0P6
         2ukfNI1WAMnm/cjqdmRSTlfx184zDHWotOQe8mG/cyHd9jHSrDmzndJkfTN0A/dzoqLM
         aO1hAkqeaQ1QerVVQJWHWkEB8ojs68IC4BBkyKbMeAy/KZrh/ywAXoGThv9N0ctqrXvh
         GKQQ==
X-Gm-Message-State: AOAM530PPJQ4EyRVoJTFcaCle+BXH8qdTuxFacJQYhvfUotVtiAu4bKs
        M7Y8Cha1WE0bD6E3/bwyJORkoze6B2DUflVHtxM1BqWW/4WYR4c0NvNpkZ5VRKDDreRt9Co4wVo
        PPgMjkXmfNt4o4FutQqgI
X-Received: by 2002:a1c:e0d4:: with SMTP id x203mr21052543wmg.91.1599468258020;
        Mon, 07 Sep 2020 01:44:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwypRVvVeDPkDqFLP39/7nc2Xlt/fAoU9PT1hj8pTEEB7uIQLs2RfJU8Z41xy99/CZDxDPOsA==
X-Received: by 2002:a1c:e0d4:: with SMTP id x203mr21052513wmg.91.1599468257771;
        Mon, 07 Sep 2020 01:44:17 -0700 (PDT)
Received: from [192.168.43.81] (93-33-122-143.ip44.fastwebnet.it. [93.33.122.143])
        by smtp.gmail.com with ESMTPSA id u13sm19269797wrm.77.2020.09.07.01.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 01:44:17 -0700 (PDT)
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Adalbert Laz??r <alazar@bitdefender.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mihai Don??u <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <d22e1e08-e2c1-510e-5ae7-accbf69731bf@redhat.com>
 <70D23368-A24D-4A15-8FC7-FA728D102475@amacapital.net>
 <836cff86-e670-8c69-6cbd-b22c5b5538df@redhat.com>
 <20200907070510.GA25834@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <494f4bea-9ea2-4dda-2e55-e564fa2ad196@redhat.com>
Date:   Mon, 7 Sep 2020 10:44:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907070510.GA25834@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 07/09/20 09:05, Christoph Hellwig wrote:
> On Fri, Sep 04, 2020 at 11:58:57PM +0200, Paolo Bonzini wrote:
>> So why say NACK?  Any half-decent maintainer would hold on merging the
>> patches at least until the discussion is over.  Also I suppose any
>> deprecation proposal should come with a description of an alternative.
>
> Please stop these totally pointless and overly aggressive personal
> attacks.  A maintainers prime job is to say no.

Christoph,

I'm not sure who is attacking whom honestly, especially since Andy later
said "Fair enough.  And my apologies for bring grumpier about SEV than
was called for" and we had a perfectly civil and technical conversation.

Paolo

