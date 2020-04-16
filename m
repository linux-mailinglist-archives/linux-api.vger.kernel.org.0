Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4B1AB96D
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 09:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437880AbgDPHKt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Apr 2020 03:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437186AbgDPHKq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Apr 2020 03:10:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5222EC061A0C;
        Thu, 16 Apr 2020 00:10:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h26so3521957wrb.7;
        Thu, 16 Apr 2020 00:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5dN5oxpwy9nSWFYmHgWall5d4CLbrW0LWzFjFt92VW8=;
        b=m+x5Ir3OUCeDFFwt2ZRIJgCEn0yllxTi4y1s94otYe4s2zRw84Sk0gSkCHj+l6uq/A
         56sx0Aqh8tHFsRbQt7K3kw6UyI5LrED+itKFV8OBTXNrOubsRNzZL2rQFfQpdh+vdH3b
         N//I51NW5XUl34hSlq5WHBXc3nocNVnzta5Fg8jkfxloJEZf9puUVGrnHnK9IeqzPliF
         inWlFnQ36/gkrwpxzTpCS686THujWbvQk2BJ8bG5E0vb/4xiNOIDt41D+eBzdrwXP30o
         NnmgDfUTJ5XDq/MxzB9loSM+JYKC8mwvm6IFzaWQxRJfO2a6JrT/azl3Y6QXW9UGobmh
         sj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5dN5oxpwy9nSWFYmHgWall5d4CLbrW0LWzFjFt92VW8=;
        b=IaEnMfzmQd9wfLlHC7975rfNMYCVwYDGVnWVON17yAGAtiXXyAdONG85FXitIOJG2w
         XnY1IG28FxlD8aJK1a4rhLQkvUnEceh0cDhfB3Tn++XNbmriSKjEtgoRB18Ffp21A5cJ
         WgoCrv4V4YA6Fbu00U9qF7fSgkrAtoUkD79IOv92G7acW3/NghGjKHel+GmDqsWC2af9
         YmfitXNb8xlS/VXnBU1uz2P6L+FtUIzI4Av7p/EBk6J1xF0By+SGgazRbM+C+4a4AfhV
         MEdsYFt0u0MpzpVI2Agtcx+Ms3E6mvVmXP3TSkJiW/7/mYtXv4MvIHHoFPXSFV92hIiq
         l5kA==
X-Gm-Message-State: AGi0PubP5OzJ9taDidtVH3hJGUGBXrDE1Fl3ZjoHe6sWV/7LB/0ep8UL
        YlBOCMT8QHrJtLiTZka1TjY5osKf
X-Google-Smtp-Source: APiQypKPg/oR4d8FSJOcfgwxG485F8H0FZzTyY8BGgh91d9W5DdLheO68gDDFzfmoiG5v0kB57ffIg==
X-Received: by 2002:adf:9cc8:: with SMTP id h8mr32095572wre.167.1587021044877;
        Thu, 16 Apr 2020 00:10:44 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id s14sm2412615wmh.18.2020.04.16.00.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 00:10:44 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Removal of the ioctl_list(2) manual page (was: Re: ioctl_list.2:
 complete overhaul needed)
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Eugene Syromyatnikov <evgsyr@gmail.com>
Cc:     mtk.manpages@gmail.com, linux-man <linux-man@vger.kernel.org>,
        Mike Christie <mchristi@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <545F8D2E.5030308@gmx.de>
 <CAKgNAkh-HBjh5AqNpTTfQjgeJVYx9LGpGDzO87zMWEmgMOd0bA@mail.gmail.com>
 <CACGkJdv5Be4KqmsP2AK99FmkZ5hB9jJk9YzsrS8Qzph8ceBvvQ@mail.gmail.com>
 <5e9b4408-410f-6fb4-9c8b-0bd68e64577d@gmx.de>
Message-ID: <ebd773bc-1277-c346-3edc-370c843cc968@gmail.com>
Date:   Thu, 16 Apr 2020 09:10:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5e9b4408-410f-6fb4-9c8b-0bd68e64577d@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[CC widened]

Hello Heinrich, Eugene,

On 4/14/20 6:21 PM, Heinrich Schuchardt wrote:
> On 2020-04-14 17:37, Eugene Syromyatnikov wrote:
>> On Tue, Apr 14, 2020 at 5:18 PM Michael Kerrisk (man-pages)
>> <mtk.manpages@gmail.com> wrote:
>>>
>>> Hello Heinrich,
>>>
>>> On Sun, 9 Nov 2014 at 16:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

[...]

>>> As you suggest, I've removed the hex values from the lists.
>>
>> Those can be replaced with the _IO* macro definitions. Meanwhile,  the
>> list is somewhat far from complete; strace has some approximation that
>> can be uses a basis of a more complete and reliable list
>> (linux/{32,64}/ioctls_inc*.h and linux/*/ioctls_arch*.h), but I'm not
>> sure if it is worth adding to the man page (moreover, entries are
>> constantly being added and changed there; yes, breaking the kernel ABI
>> in the process sometimes).
> 
> Man-pages like netdevices.7 or ioctl_fat.2 are what is needed to help a
> user who does not want to read through the kernel code.
> 
> If ioctl_list.2 has not been reasonably maintained since Linux 1.3.27
> and hence is not a reliable source of information, shouldn't it be dropped?

As already noted, I'm inclined to agree that yes, this page probably
should be removed. What really is needed is pages such as ioctl_fat(2),
ioctl_userfaultfd(2), and ioctl_ns(2) that give useful details
to user-space programmers.

Just FYI, I've queued a change that removes the ioctl_list(2) page
in a private branch. By the time of the next release, I'll merge
that branch, unless someone has (good) objections.

There is one piece of ioctl_list(2) that is perhaps worth preserving:
the "ioctl structure" subsection. As part of these changes, I've
migrated that text to ioctl(2).

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
