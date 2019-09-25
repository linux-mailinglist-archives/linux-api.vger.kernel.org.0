Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3916EBDF9A
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 16:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407183AbfIYOCH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 10:02:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34252 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405102AbfIYOCH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 10:02:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so7136083wrx.1;
        Wed, 25 Sep 2019 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F7vgeZSQPCok6+67LjXBzohtslp7p/FxL4eCR3C05lk=;
        b=rB5xmoq5jZX1E5E3euLtcidJawgqXBAqMbR8O7LhiQ1XoRna7hyVR90F944A+11Fpz
         Ue9dqxOv6f0XD/yvu7hk3ucIX5QpNP4FxxYVmrtDFHb7qjwxjbV1cyiL5CO1cMkBQdR8
         e86YXa9GIOpf48hDg1kn6w1ZuPU0QaYpQNgcBqzB+q3GNkyMcDb2l+mPJNzb8OcHykfw
         fQNEaHoA0NgHtNuUvyiAII/BHkTEZW2PBZ/R0oi42XQ2Vlvm1CmDXheKTb7sywojDLOV
         X5eJQBHaFSLjrFV2pKbI2frR4XJvM1Kgg/lVBoVTuj5dvfMGCFz+Mn3cV9khsnxhRAy0
         IZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F7vgeZSQPCok6+67LjXBzohtslp7p/FxL4eCR3C05lk=;
        b=WuE9aHfq8jDZdfA0LIAQmxJyrPsyCFGJw6L5YlNiAaTvMXuZzSPTtDttShZOSxSyiw
         Qy0Q3ubagLlSkDLFQwE3VytLwFCgcEfnwHR6aG4n/2tvBZtfng6MwExThGnisZzfor/7
         FpaiRo+Jy6GBOhZV1I8PnnVKqkGuTMH/fV7kX8P/aghLzmzBNKeJj5sle3/jPCv1Jkkk
         iGNvlthP2E/LyXEM3pBBU6MXDILvBnngCayAQea9GXTnz9I+VZqiD7y4AVM773ErDkLS
         3dUA3RaDF8FgpwtvMLqd7CDZSKKCB5GMVeILOQ64PbqrMfo9+1NIBYaEEW557G3y0n5v
         +xVA==
X-Gm-Message-State: APjAAAVUd1ZwGIxBVBBbqAwOvmLUTYCN6nnFht9qbCaakpC8XBrhByLg
        F/27HdDM448qJfZsW3hBSIw6jY9Z
X-Google-Smtp-Source: APXvYqyYrs5HA+LWpoO/rHQ44KUuOPazN3W8FjyPYgTUo4aLnTva+qW+9gWsKsTG16/JdVzKyp/LHA==
X-Received: by 2002:a5d:6451:: with SMTP id d17mr10443674wrw.260.1569420123040;
        Wed, 25 Sep 2019 07:02:03 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id r13sm8314034wrn.0.2019.09.25.07.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 07:02:02 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     Florian Weimer <fw@deneb.enyo.de>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de>
 <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
 <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com>
 <20190924195701.7pw2olbviieqsg5q@wittgenstein>
 <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
 <20190924215316.gxev2anuqffegocw@wittgenstein>
 <331cc245-3f70-dd43-31f9-8c1680ca6b20@gmail.com>
 <87h850scux.fsf@mid.deneb.enyo.de>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <5d941e9e-aba9-8929-66e9-93ae19e11757@gmail.com>
Date:   Wed, 25 Sep 2019 16:02:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87h850scux.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/25/19 3:51 PM, Florian Weimer wrote:
> * Michael Kerrisk:
> 
>>        If these conditions don't hold true, then the child process should
>>        instead be created using clone(2) with the CLONE_PID flag.
> 
> I think this should be CLONE_PIDFD.

Thanks Florian. Fixed.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
