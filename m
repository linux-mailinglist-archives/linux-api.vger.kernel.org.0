Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066B6232F5D
	for <lists+linux-api@lfdr.de>; Thu, 30 Jul 2020 11:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgG3JQ7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jul 2020 05:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgG3JQ7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Jul 2020 05:16:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF0FC061794;
        Thu, 30 Jul 2020 02:16:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a21so27211602ejj.10;
        Thu, 30 Jul 2020 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QKcnc8Aqr1chcusd+6sJkpdtZLqBuC1B6x2jdVQqzgM=;
        b=ncyM/+OVZllzruYDxXQfd8r6M6il+xv3SZ2j7Eu3s3WHGlowl88+SbOcixVZGIwIAl
         41jOoclWK6TL62PkpSAt6tEqh2sQ2rCbvKzcAg88yEA1nKMhvGalnTFu9kaSQ9CxRl1y
         fmv2pVsDoR6Y789kln5re/mLVWE+lYhqsXtnG+roqV2O5ARl+FuOuC4OyST8WqHLkExc
         Jq13PR0CaI+HD2e8TpevrZAAzMa4ig1PcbUT6/wZlaPykBZel3co80YgdpPw8AfjyEgQ
         Q2HMSjNjIQUhfNOYxgC4f7iBECp422wgsHx6w1F5fDXT558pzwPG71jJGf7mBEWymURh
         P/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QKcnc8Aqr1chcusd+6sJkpdtZLqBuC1B6x2jdVQqzgM=;
        b=uIXpdUurhPTEZ3F6c46HQVGINolYJZax073ubm0PumBnuoSXtkij844cTBa2JiHbPV
         9nPLKaa/7lEU8qjzpETJGyiZbpIFruOJTWYu5hfebpVWwp6WXlBOmVNc2E9RE3BDbqEp
         tFo6XvrCwvMFNf75O8XhDfb4JIhcBqCtGmS/OY6q3MJSqHfbv0ilR0BhFWdO7nnlpJ6V
         K8+Yb7CRkDRjDlbAIcouY4hrBmsFRgk7su4G3Nh90bonE//fFbVToOnCf5u/JGE2Ncpt
         Bhz5jsN9jtERYlsQJsjrm1QojbrXCrV2lul/WCULEwChFcipS+Vy8UrLskntlGicOzIm
         Lkcw==
X-Gm-Message-State: AOAM532zRRrCR74G+BCBB4BdFiNKPyzV7aOVAlkND6Po2RdK63yMV8Ih
        q01LZo6PoejxslPa5h1l6ZVVcPBs
X-Google-Smtp-Source: ABdhPJwdiXbqfDjC/Eun9qiqYlaZfRBQjZS17hXfP5sc/DEO6W0TOqUzmEkz2DU4PQC1tBgdc+e4nA==
X-Received: by 2002:a17:906:a2c2:: with SMTP id by2mr1630521ejb.86.1596100617335;
        Thu, 30 Jul 2020 02:16:57 -0700 (PDT)
Received: from ?IPv6:2001:a61:3adb:8201:9649:88f:51f8:6a21? ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id s4sm5048639ejx.94.2020.07.30.02.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 02:16:56 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>,
        Zack Weinberg <zackw@panix.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH] Replacing "master-slave" terminology for
 pseudoterminals
To:     enh <enh@google.com>
References: <b3b4cf95-5eaa-0b4e-34cc-1a855e7148b6@gmail.com>
 <CAJgzZopP=O1cZ2M=3h6Q-X08+eVMPQE_zOCnsEjN=hUTHOkYwQ@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <24960dff-1d54-b617-26ba-bad168e70ee8@gmail.com>
Date:   Thu, 30 Jul 2020 11:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJgzZopP=O1cZ2M=3h6Q-X08+eVMPQE_zOCnsEjN=hUTHOkYwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Elliot,

Thanks for looking at the patch.

On 7/29/20 6:31 PM, enh wrote:
> yeah, the old terminology was so non-obvious that reading through this,
> every change seemed like an improvement in clarity.
> 
> my only suggestion would be to consistently use tty_fd and pty_fd in the
> function signatures rather than just fd. (the presence or absence of 'p' in
> the function name is a clue, i hadn't picked up on that until i
> tried rewriting code to use pty/tty rather than master/slave.)

Yes, I've made that change now also.

> (aside: i was surprised by multiplexor rather than multiplexer, but grep
> says man7.org has 2 multiplexors to 1 multiplexer, so lgtm.)

Carlos also commented on this. I've changed it (and also
in other manual pages where "multiplexor" appeared)


Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
