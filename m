Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874F425D858
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 14:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgIDMEB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 08:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgIDMDu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 08:03:50 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC9C061244
        for <linux-api@vger.kernel.org>; Fri,  4 Sep 2020 05:03:48 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e7so4326175qtj.11
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Mcw/H8h1VHTQQIn4YHF2jKnhhsI9aamPezUJ5gu5VS8=;
        b=YccFy2/jRyiiNuOyFaKkQdGXFuUT7lEkoMqqOyZjG1Wmu/pu5iyWP0EOsHG4UOBFjW
         SZyuWHTfRbgtnKDKmIHCCEiDC8pgzN5JlBEAVU4NU8HPTwx/IAFbgYDOx1ua+lAfWaQY
         E98khe1Wy6p+9yP+3cT5GVbPSjsPuqn+FoBwNUMnXtXz/mKeB2C53QAJ7jHtix8wdQ9d
         XyE2h1NhfJ8EL9xSf15P236JWSiaK+rhtpvcBdOOge35GaHp8lD6KxCkKs5CPODrqlvn
         BpnHmyP2Va5jdeM9oAxPtymDP3g4XByh5Mo7PtmzU/Cr4oZZeXPc+RiyUUlxXGS05agd
         IlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mcw/H8h1VHTQQIn4YHF2jKnhhsI9aamPezUJ5gu5VS8=;
        b=aIeq0dIu5G5RjM+gL113cTEVXCA49IVw6eOP7JVyawQHs+2eGetWEpjUdIw9ZVrJSd
         xqcRnOC4chSdR+3Bc2ZEhpno1KeBDG2i5Prmu10TMMPRZ6VEUp25LZ9wlc5EaPr0L3UD
         TA7C6sxCAA5ub1pGI+sYuHkBx5CYIU2E3SUGeD6cBmcTNZQ/w8wbr77RZ9vAfsIjTtZJ
         dDb8gXlbkJtwr+pClZsOAkrGJmFOfraivZGCPFADNrfyZdsPeqmWVopdXgoF+ObtwYcI
         CQ5njZUz9pMEP5Z+6VYzu+as32mLwU4gYq6K/ACnb1JVvYdtSODmw0R9PhIl7vYP7+AO
         NFmA==
X-Gm-Message-State: AOAM531jvs+ies4Xy8hbQ9PClBcP1pAi9TTYSa2pxWet/BREW7empvMa
        D6l4p2tySTVEk4CO3aMkw7GyzA==
X-Google-Smtp-Source: ABdhPJwd1Wo43ylopd9W1v3J0e6eNCSTCiu92uqW7nAq4mGomZoXvJLfjFEaCme8U9R/znjEmBEGbw==
X-Received: by 2002:ac8:12c4:: with SMTP id b4mr8472783qtj.224.1599221025628;
        Fri, 04 Sep 2020 05:03:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b43sm4350969qtk.84.2020.09.04.05.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:03:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kEARU-007I1L-Bt; Fri, 04 Sep 2020 09:03:44 -0300
Date:   Fri, 4 Sep 2020 09:03:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RESEND RFC PATCH 3/5] mm/mmu_notifier: remove lockdep map,
 allow mmu notifier to be used in nested scenarios
Message-ID: <20200904120344.GQ24045@ziepe.ca>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904113116.20648-4-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904113116.20648-4-alazar@bitdefender.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 02:31:14PM +0300, Adalbert Lazăr wrote:
> From: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
> 
> The combination of remote mapping + KVM causes nested range invalidations,
> which reports lockdep warnings.

You need a better solution than this, this lockdep is protecting a lot
of other more common code against various errors.

Jason
