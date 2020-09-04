Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0A425E263
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 22:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIDUId (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 16:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbgIDUIc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 16:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599250111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rx/MrJrBjON2MHt5LyXI11U1Seqyg13O7xGK8kHsIoY=;
        b=D3BSQYBGPBOLIGWRFLK7qqOmjKbIMbZz1ba2DrA8xDL2bNqEUubBAXNPsfYBAf55SEIdJ2
        poL0RJtWvZyLiauGl8LTmu19+0Ck4bVCmZlKVPc6yypwMEr2CBbr85nKIGJwj1qICuNp3p
        c4cCajVVOFfXoLwdibmepVK6B/zBXKM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-lmGa9-VoNO2_sMpi92FMTg-1; Fri, 04 Sep 2020 16:08:15 -0400
X-MC-Unique: lmGa9-VoNO2_sMpi92FMTg-1
Received: by mail-ed1-f72.google.com with SMTP id n25so3120374edr.13
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 13:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rx/MrJrBjON2MHt5LyXI11U1Seqyg13O7xGK8kHsIoY=;
        b=AD8Fl93aMBWBOp3lis+K46uff8VsEE/gnVNLSplGbLPOjB1A1QqcyVZLEdgAiYbTbu
         b3n/MuRkTkofsvEep6awz9/251PsZiu36R7Dhvmrey1JuN3UzGEeJUXaFHtWeHfflwFl
         8JiKK9XK5F3nkneU6+ksoou0gQLV7r4M2SKGr+cXS7z3JW65eIiLWs27ApD7c9BNTDgT
         efGp/LNOjuLYi5lz7VqG/pAY+hlG8LhiKn5u4Ty5CB7WYHNyBy3r4cVCbl02TGpq2sBG
         d+547tDggzM4JMD/Hi1NEn9r7i9f4gCf8lKzFnuiwMcDOUtERYBBY69Z6wJkBOXGF0JP
         axcQ==
X-Gm-Message-State: AOAM5334QWE/qSdqT5m8t9enqaeOjv+PjUj4f6Ket80JoEmNFYhrpD4a
        Sz6swHaw46RMnKYDFbqtwTWwi4HgFjx8Yootaur9OgU2YxOTvv970PGJAg9Kz9QRDZBuhHoEqI1
        VCzwEb/vS42LEbYBD3TCd
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr9058607ejy.162.1599250094045;
        Fri, 04 Sep 2020 13:08:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ0UoNYy5Xw/wkWRcGO3CqSDHSu/bI9UKBdSj6xmuqYNYindMGVrqenMWuWm7GhIdJ9AVESA==
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr9058576ejy.162.1599250093821;
        Fri, 04 Sep 2020 13:08:13 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id d2sm7138622ejm.19.2020.09.04.13.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 13:08:13 -0700 (PDT)
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
To:     Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
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
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904121148.GR24045@ziepe.ca>
 <20200904194139.GA5881@casper.infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bcc4affe-416e-ccb6-1ab1-5144de30f546@redhat.com>
Date:   Fri, 4 Sep 2020 22:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904194139.GA5881@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 04/09/20 21:41, Matthew Wilcox wrote:
> Proposal: http://www.wil.cx/~willy/linux/sileby.html
> Start at implementation:
> http://git.infradead.org/users/willy/linux.git/shortlog/refs/heads/mshare

The main difference between mshare() and this is that we don't want an
all-or-nothing thing.

Adalbert's introspection thing is rather simple, but what I would like
to be able to do (and the reason why I suggested the multi-pidfd
approach) is actually a bit more complex:

- a parent process creates a range of memory

- there are multiple VMs child processes.  One of this VM is a primary
VM, the others are enclave VMs.  VMs are created by the parent process
and each VM gets a different view of the memory range through pidfd_mem.

- once an enclave VM is created, the primary VM must not be able to
access the memory that has been assigned to the enclave VM.  If the
parent unmaps the memory in the primary VM, the child must SIGBUS when
it's accessed.

- if memory is removed from a VM and assigned to another, this should
not involve any copy at all.

For this usecase the range of memory would be backed by hugetlbfs,
anonymous memory, VFIO, whatever.  Userfaultfd is certainly part of the
picture here on the VM side.  Having userfaultfd on the parent side
would be nice though I don't have a use for it right now.  I'm not sure
about non-anonymous VMAs.

Thanks,

Paolo

