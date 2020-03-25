Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC361933E7
	for <lists+linux-api@lfdr.de>; Wed, 25 Mar 2020 23:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCYWyT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Mar 2020 18:54:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42115 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWyT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Mar 2020 18:54:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id 22so1790976pfa.9
        for <linux-api@vger.kernel.org>; Wed, 25 Mar 2020 15:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zWrlA6w6KYYZ/OQNIhCJ+kzEqHzJfgJzyL3tKc0pOFY=;
        b=GrcaqC4AWSa41GjxW25/ttATFM2cptZf/vbSCIUyFim8YoRmejCkibyIkocjqgOtk7
         gQi2rf3Jr4vTpigiIKR03omj8m8g4PSS1/hWBn+1P66ftzknSJmfc7QPDRWJWr5fxOPH
         1tgLDDziQjRk/dNQg7ElbWcilrplyXjDewFbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zWrlA6w6KYYZ/OQNIhCJ+kzEqHzJfgJzyL3tKc0pOFY=;
        b=KLYZNpxmNs/5KjYr9pH0LUECGa1veMCN3VJVy0JlrJVaptE0LOba4kNOR/e9J5W8Uc
         ixjM3bTJxPXjN/kfsKmW6xw+b+G87y/nDc0a3O3BNTUeVsyks8/9/07TU8y2wrp1IBI7
         Y++WZsHC01QT1giOlJjHbX5QWmlD1kjxr5CpXaSzwKxNhrSf4Nm5ymNdlJ5MfjUr9m2V
         qrgdwHvtsDz6+hfflaVKR60qYkchH8A774+zJ1Tu5hOKZNqpgom3VH9/q8JJDJLqp8vH
         TH29D9IUfjmucc1LD5ipz7++HJpua8G5jJEcZRqY9+SfbdJlE5gamVL4SIEmYvWZmLnv
         DR9A==
X-Gm-Message-State: ANhLgQ1IhoZvBI2Oo0q8O4c3ivrfgGzPvLM/lR0fxsmHT3hGuhkVuVMj
        Y8b9TUvWnG2GpqYd/WtWoo9maQ==
X-Google-Smtp-Source: ADFU+vsY3wfDo2Gy2J9cIPa/hwVB5bzrF7RpYHjEgTaZRdPrm7yugsdq0Qkl+UrqzZzltSS9IKTavw==
X-Received: by 2002:a63:6d02:: with SMTP id i2mr5218276pgc.267.1585176850880;
        Wed, 25 Mar 2020 15:54:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p70sm226890pjp.47.2020.03.25.15.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:54:10 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:54:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003251544.7ECB392A7@keescook>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <874kuc5b5z.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kuc5b5z.fsf@x220.int.ebiederm.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 25, 2020 at 05:20:40PM -0500, Eric W. Biederman wrote:
> Hmm.  There is a big gotcha in here and I think it should be mentioned.
> This code only works because no one has done set_fs(KERNEL_DS).  Which
> means this only works with strings that are kernel addresses essentially
> by mistake.  A big fat comment documenting why it is safe to pass in
> kernel addresses to a function that takes a "char __user*" pointer
> would be very good.

Yeah, I was going to mention this too just now as I went looking through
one of the handlers and was reminded that the args are marked __user. :P

I suspect we might need to add some __force __user markings or something
(with a comment as you say above), to keep sparse from going crazy. :)

-- 
Kees Cook
