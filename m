Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477D119BABC
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 05:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgDBDqa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Apr 2020 23:46:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35639 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732381AbgDBDqa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Apr 2020 23:46:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id c12so840055plz.2;
        Wed, 01 Apr 2020 20:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=irKR80qP9k8TjfFuU8l+xZfjluKvW+3Yb/RYEDtITGA=;
        b=SWurKRahRvkibrH6/GUzyENNWCJMBHN8p928YZQym/BUwcR8CW7V04UfGfr9sz/PNO
         oAmpROU6obl24+sjJAA/w6hzdBQKe9MEJvkCq0YNCkLVg9IS3IuIzHxf+blM2SVOKA0C
         6Of8XrPRQJ3RXay7derX0Jj5tfvoAYDa9ZtqjCxdQ9wvxPwttEdF71AMZYwAFRSHrvMx
         qmHt088mtr3vyWc7eLw/7goQoGYt23g1VLt2ClAgZBld8/ruXGl2JbMVdV17hYkG/czN
         E6n087Z2CzDNe/I/6Ck5TRfAlQVc/e3QosjnOOwvvkz3EWwBZQKQb5wwnyJJHJFYEQpV
         QxDA==
X-Gm-Message-State: AGi0PuYSt9MsgZdsmyTATtlCwsEoSWn1MaY+nncQjJP6jcWTKRjfkrNg
        IUPW+dmiweyVlzn9LfJ+p8+FLBe4v0E=
X-Google-Smtp-Source: APiQypIGHcqjtOQmCNAbsB4+p0Y+o8cjsqUQrDmUUZJ7wEwgLYSrbWxvCk3BgCsNeMCtb7WGHO6/HA==
X-Received: by 2002:a17:902:b702:: with SMTP id d2mr1046890pls.211.1585799188573;
        Wed, 01 Apr 2020 20:46:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:d5ca:bbdc:67fa:c3da? ([2601:647:4000:d7:d5ca:bbdc:67fa:c3da])
        by smtp.gmail.com with ESMTPSA id l9sm813076pff.16.2020.04.01.20.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 20:46:27 -0700 (PDT)
Subject: Re: [PATCH] prctl.2: doc PR_SET/GET_IO_FLUSHER - V4
To:     Mike Christie <mchristi@redhat.com>, linux-api@vger.kernel.org,
        david@fromorbit.com, mhocko@suse.com, masato.suzuki@wdc.com,
        damien.lemoal@wdc.com, darrick.wong@oracle.com,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
References: <20200402020850.7218-1-mchristi@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <9eab1b92-6a44-616a-44b2-f1ee6475f6f0@acm.org>
Date:   Wed, 1 Apr 2020 20:46:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402020850.7218-1-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2020-04-01 19:08, Mike Christie wrote:
> +.TP
> +.B PR_GET_IO_FLUSHER (Since Linux 5.6)
> +Return as the function result 1 if the caller is in the IO_FLUSHER state and
> +0 if not.

Although I'm not at all a language expert, the word order at the start
of the above sentence seems a bit weird to me?

Thanks,

Bart.
