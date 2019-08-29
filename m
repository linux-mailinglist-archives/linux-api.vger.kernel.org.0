Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832E0A22F7
	for <lists+linux-api@lfdr.de>; Thu, 29 Aug 2019 20:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfH2SFy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 29 Aug 2019 14:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfH2SFw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Aug 2019 14:05:52 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2999A793ED
        for <linux-api@vger.kernel.org>; Thu, 29 Aug 2019 18:05:52 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id w22so2648162edx.8
        for <linux-api@vger.kernel.org>; Thu, 29 Aug 2019 11:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XnQ5OvmJcjZ763Ru15zt4QsophfhQ/CzM5dYjcfw5h0=;
        b=jsaWqG6JJtm/tSg8FP1rTan7NVLRQOy5U9sb64T69BME+EkwCmX502c7T8EB4SFhjJ
         FmFITfRXDp8QS/LEVsjujx4D4Sq10Rj7YLpASy0WIVX+yNOOpqIP7hhE0c1b1VMl+7EC
         SeCV33mN9D5L9+cgTbIXe59Wg59G4dj5QzkuYz0m99LPyle/kuSuQCZ/zYPOTeFEaLSS
         eOG5l5WONuItJMPJO+V7GLIq2w2PSgiQ5IgKrYUO0VTYfWhrtGV1Te1I0mLQ1Ur0tvdP
         wwJugQ/EAi7287+dt1OfKqfJ/VGqjCuQV0+hcyVhnD9bXVrkwN6IqYwBWINVC9ylNAdH
         A86A==
X-Gm-Message-State: APjAAAUTZaLTa9ki8Dk1KuBN5TubvX1Ptw5btbbWcWhHZYQc5LEfkpPX
        MB49sBfrei378T+H75Hy4r1ncesFFJqFuHKE9J66cqO7b2wZrDbH4FXd+urwnootKkQmO42/Rpx
        24znZEKXXos2Rt5S7V8xR
X-Received: by 2002:a17:907:11c4:: with SMTP id va4mr9409879ejb.261.1567101950926;
        Thu, 29 Aug 2019 11:05:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyP9jB9e80k1SGJ4g4J+yigCbv04dAehOdW5zmTqivhMVtVDL7jQeEOMYjq+U1RNwiAYvXfvg==
X-Received: by 2002:a17:907:11c4:: with SMTP id va4mr9409835ejb.261.1567101950682;
        Thu, 29 Aug 2019 11:05:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id r23sm573998edx.1.2019.08.29.11.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 11:05:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3ECDD181C2E; Thu, 29 Aug 2019 20:05:49 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, luto@amacapital.net,
        davem@davemloft.net, peterz@infradead.org, rostedt@goodmis.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org, brouer@redhat.com
Subject: Re: [PATCH v2 bpf-next 1/3] capability: introduce CAP_BPF and CAP_TRACING
In-Reply-To: <20190829172410.j36gjxt6oku5zh6s@ast-mbp.dhcp.thefacebook.com>
References: <20190829051253.1927291-1-ast@kernel.org> <87ef14iffx.fsf@toke.dk> <20190829172410.j36gjxt6oku5zh6s@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Aug 2019 20:05:49 +0200
Message-ID: <87imqfhmo2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Aug 29, 2019 at 09:44:18AM +0200, Toke Høiland-Jørgensen wrote:
>> Alexei Starovoitov <ast@kernel.org> writes:
>> 
>> > CAP_BPF allows the following BPF operations:
>> > - Loading all types of BPF programs
>> > - Creating all types of BPF maps except:
>> >    - stackmap that needs CAP_TRACING
>> >    - devmap that needs CAP_NET_ADMIN
>> >    - cpumap that needs CAP_SYS_ADMIN
>> 
>> Why CAP_SYS_ADMIN instead of CAP_NET_ADMIN for cpumap?
>
> Currently it's cap_sys_admin and I think it should stay this way
> because it creates kthreads.

Ah, right. I can sorta see that makes sense because of the kthreads, but
it also means that you can use all of XDP *except* cpumap with
CAP_NET_ADMIN+CAP_BPF. That is bound to create confusion, isn't it?

-Toke
