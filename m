Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3049D67F6
	for <lists+linux-api@lfdr.de>; Mon, 14 Oct 2019 19:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbfJNRGU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 14 Oct 2019 13:06:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41426 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbfJNRGU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Oct 2019 13:06:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so10722780pfh.8
        for <linux-api@vger.kernel.org>; Mon, 14 Oct 2019 10:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=4wEn60A6RXyBZ4Vk9mnpm7mGwaECr6v0DgV7LVsvhjQ=;
        b=AhuiMEh/SnEYYnxmdDyLMLVcnowAx/piHBlcqjJH3w3hNnUxh/IcWugBcKke+sKv9v
         YQ7EgkJ+3VjibqQD5lpY3F7T6vbNrmhs20gEhlUy2XhZPlxO/vzSL4YKC//vHPBdUo14
         WPCy7UnvEGfRFT4kzJL/LF4Pmf5DYPuI0+B/ei8BagXudFNHC85QPTZMzgeMzg7RAELZ
         ZzfBmlioVdX/k6UQPpET7Ya61QFeqzuDbpa3aILowVqwwnA3AQXiAb9+Y6wD77PKaYXD
         /mkVn8lrfFNaloFYxQ/tCYPdtqLz44HNDO6Ah8Mdi8CJ0diRmvUfNtkPLLATjH3a7Jz9
         6cTg==
X-Gm-Message-State: APjAAAUoS7F8PGt2YX3PlxwpAEHaTd+5uOd6x5swkgwmdEltWlHrS02/
        wpxaivN34Q8X4pQTYKHlbpkjRw==
X-Google-Smtp-Source: APXvYqzU8AOIvBjXgydi0mXAdWHx1j+dP1jry5Nxs9/aJaS9iXOEQQvoHUpV30bcNldS+pHj0fIlng==
X-Received: by 2002:a62:e70d:: with SMTP id s13mr34065283pfh.224.1571072778754;
        Mon, 14 Oct 2019 10:06:18 -0700 (PDT)
Received: from [25.171.81.230] ([172.58.27.78])
        by smtp.gmail.com with ESMTPSA id w189sm19608978pfw.101.2019.10.14.10.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 10:06:17 -0700 (PDT)
Date:   Mon, 14 Oct 2019 19:06:08 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAG48ez0SG3LLeLtqmf5Q8aZL3J8b5XwgNbgDr72jSnq2QBac8Q@mail.gmail.com>
References: <CAG48ez1hk9d-qAPcRy9QOgNuO8u3Y_hu_3=GZoFYLY+oMdo8xg@mail.gmail.com> <20191012101922.24168-1-christian.brauner@ubuntu.com> <CAG48ez0SG3LLeLtqmf5Q8aZL3J8b5XwgNbgDr72jSnq2QBac8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] pidfd: add NSpid entries to fdinfo
To:     Jann Horn <jannh@google.com>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Kellner <christian@kellner.me>,
        Christian Kellner <ckellner@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <9408F586-8386-4D52-A687-A4BFF250E9BD@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On October 14, 2019 5:09:58 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
>On Sat, Oct 12, 2019 at 12:19 PM Christian Brauner
><christian.brauner@ubuntu.com> wrote:
>> Currently, the fdinfo file of contains the field Pid:
>
>nit: something missing after "of"?
>
>> It contains the pid a given pidfd refers to in the pid namespace of
>the
>> opener's procfs instance.
>
>s/opener's // here and in various places below? "the opener's" is
>kinda misleading since it sounds as if it has something to do with
>task identity.
>
>> If the pid namespace of the process is not a descendant of the pid
>> namespace of the procfs instance 0 will be shown as its pid. This is
>> similar to calling getppid() on a process who's parent is out of it's
>
>nit: s/who's/whose/
>
>nit: s/it's/its/
>
>> pid namespace (e.g. when moving a process into a sibling pid
>namespace
>> via setns()).
>
>You can't move a process into a PID namespace via setns(), you can
>only set the PID namespace for its children; and even then, you can't
>set that to a sibling PID namespace, you can only move into descendant
>PID namespaces.

Yes, I know. This was sloppy changelogging on my part.

>
>> Add an NSpid field for easy retrieval of the pid in all descendant
>pid
>> namespaces:
>> If pid namespaces are supported this field will contain the pid a
>given
>> pidfd refers to for all descendant pid namespaces starting from the
>> current pid namespace of the opener's procfs instance, i.e. the first
>
>s/current // - neither tasks nor procfs instances can change which pid
>namespace they're associated with

Yes.

>
>> pid entry for Pid and NSpid will be identical.
>
>*the Pid field and the first entry in the NSpid field?

Yes.

>
>> If the pid namespace of the process is not a descendant of the pid
>> namespace of the procfs instance 0 will be shown as its first NSpid
>and
>> no other NSpid entries will be shown.
>> Note that this differs from the Pid and NSpid fields in
>> /proc/<pid>/status where Pid and NSpid are always shown relative to
>the
>> pid namespace of the opener's procfs instace. The difference becomes
>> obvious when sending around a pidfd between pid namespaces from
>> different trees, i.e. where no ancestoral relation is present between
>> the pid namespaces:
>> 1. sending around pidfd:
>> - create two new pid namespaces ns1 and ns2 in the initial pid
>namespace
>>   (Also take care to create new mount namespaces in the new pid
>>   namespace and mount procfs.)
>> - create a process with a pidfd in ns1
>> - send pidfd from ns1 to ns2
>> - read /proc/self/fdinfo/<pidfd> and observe that Pid and NSpid entry
>>   are 0
>> - create a process with a pidfd in
>
>truncated phrase?

Yeah, as I said this was really just a rough draft for Christian (the other one :)).

>
>> - open a pidfd for a process in the initial pid namespace
>> 2. sending around /proc/<pid>/status fd:
>> - create two new pid namespaces ns1 and ns2 in the initial pid
>namespace
>>   (Also take care to create new mount namespaces in the new pid
>>   namespace and mount procfs.)
>> - create a process in ns1
>> - open /proc/<pid>/status in the initial pid namespace for the
>process
>>   you created in ns1
>> - send statusfd from initial pid namespace to ns2
>> - read statusfd and observe:
>>   - that Pid will contain the pid of the process as seen from the
>init
>>   - that NSpid will contain the pids of the process for all
>descendant
>>     pid namespaces starting from the initial pid namespace
>
>You don't need fd passing for case 2, you can just look at the procfs
>instance that's mounted in the initial mount namespace. Using fd
>passing in this example kinda obfuscates what's going on, in my
>opinion.

My goal was to illustrate the same mechanism leading to different results.
But I don't care much about how this is described as long as I illustrates the difference.

>
>
>> +/**
>> + * pidfd_show_fdinfo - print information about a pidfd
>> + * @m: proc fdinfo file
>> + * @f: file referencing a pidfd
>> + *
>> + * Pid:
>> + * This function will print the pid a given pidfd refers to in the
>pid
>> + * namespace of the opener's procfs instance.
>> + * If the pid namespace of the process is not a descendant of the
>pid
>> + * namespace of the procfs instance 0 will be shown as its pid. This
>is
>> + * similar to calling getppid() on a process who's parent is out of
>it's
>> + * pid namespace (e.g. when moving a process into a sibling pid
>namespace
>> + * via setns()).
>> + * NSpid:
>> + * If pid namespaces are supported then this function will also
>print the
>> + * pid a given pidfd refers to for all descendant pid namespaces
>starting
>> + * from the current pid namespace of the opener's procfs instance,
>i.e. the
>> + * first pid entry for Pid and NSpid will be identical.
>> + * If the pid namespace of the process is not a descendant of the
>pid
>> + * namespace of the procfs instance 0 will be shown as its first
>NSpid and
>> + * no other NSpid entries will be shown.
>> + * Note that this differs from the Pid and NSpid fields in
>> + * /proc/<pid>/status where Pid and NSpid are always shown relative
>to the
>> + * pid namespace of the opener's procfs instace. The difference
>becomes
>> + * obvious when sending around a pidfd between pid namespaces from
>> + * different trees, i.e. where no ancestoral relation is present
>between
>> + * the pid namespaces:
>> + * 1. sending around pidfd:
>> + * - create two new pid namespaces ns1 and ns2 in the initial pid
>namespace
>> + *   (Also take care to create new mount namespaces in the new pid
>> + *   namespace and mount procfs.)
>> + * - create a process with a pidfd in ns1
>> + * - send pidfd from ns1 to ns2
>> + * - read /proc/self/fdinfo/<pidfd> and observe that Pid and NSpid
>entry
>> + *   are 0
>> + * - create a process with a pidfd in
>> + * - open a pidfd for a process in the initial pid namespace
>> + * 2. sending around /proc/<pid>/status fd:
>> + * - create two new pid namespaces ns1 and ns2 in the initial pid
>namespace
>> + *   (Also take care to create new mount namespaces in the new pid
>> + *   namespace and mount procfs.)
>> + * - create a process in ns1
>> + * - open /proc/<pid>/status in the initial pid namespace for the
>process
>> + *   you created in ns1
>> + * - send statusfd from initial pid namespace to ns2
>> + * - read statusfd and observe:
>> + *   - that Pid will contain the pid of the process as seen from the
>init
>> + *   - that NSpid will contain the pids of the process for all
>descendant
>> + *     pid namespaces starting from the initial pid namespace
>> + */
>
>See above, same problems as in the commit message. Actually, since you
>have a big comment block with this text, there's no reason to repeat
>it in the commit message, right?

If the comment gets modified or the logic changes I'd still like to have the actual context recorded in the changelog too.
I think that's good practice.

>
>(By the way, only slightly related to this patch: At the moment, if
>you have a pidfd to a task that has already been reaped, and the PID
>has been reallocated to another task, the pidfd will still show up in
>/proc/*/fdinfo/* as if it referred to a non-dead process, right? Might
>be worth considering whether you want to probe ->tasks[PIDTYPE_PID] or
>->tasks[PIDTYPE_TGID] for NULL-ness when printing fdinfo, or something
>like that.)

Not a big deal but yes, let me put this on my list.
Or do you feel in the mood for a patch? ;)

Christian

