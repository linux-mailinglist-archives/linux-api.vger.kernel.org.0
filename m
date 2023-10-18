Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA5A7CDF22
	for <lists+linux-api@lfdr.de>; Wed, 18 Oct 2023 16:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345011AbjJRORU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Oct 2023 10:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345065AbjJRORE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Oct 2023 10:17:04 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26192449B;
        Wed, 18 Oct 2023 07:15:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4S9XXk2rD7z9v7Nc;
        Wed, 18 Oct 2023 21:59:50 +0800 (CST)
Received: from [10.221.98.153] (unknown [10.221.98.153])
        by APP1 (Coremail) with SMTP id LxC2BwBHU5Rl6C9lCP90Ag--.36102S2;
        Wed, 18 Oct 2023 15:15:10 +0100 (CET)
Message-ID: <283bf52d-af6e-4d20-a5ba-d98511c2e530@huaweicloud.com>
Date:   Wed, 18 Oct 2023 16:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-integrity@vger.kernel.org
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
 <20230912205658.3432-1-casey@schaufler-ca.com>
 <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
 <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
 <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
 <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com>
 <468436cf766732a3cfc55d07ad119a6ccdc815c1.camel@huaweicloud.com>
 <CAHC9VhTjHT-DGKu0=cZPVb=+kMwmbPdr8HiVWJq-yzaDiYk_SA@mail.gmail.com>
 <6f33144c850c40e9438a6de2cf3004e223508755.camel@huaweicloud.com>
 <2637d5294d4a7ae871f1b758f5a30234836e2463.camel@huaweicloud.com>
 <c896c8ed559d0075146070be232e449b6951eb99.camel@linux.ibm.com>
Content-Language: en-US
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <c896c8ed559d0075146070be232e449b6951eb99.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHU5Rl6C9lCP90Ag--.36102S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF45AryfGF18KF4UuF1UAwb_yoWrJFy8pF
        WUKa15tF4kZr1jkrn2va1rAw4UKrWrXryUWr98Gry8Za4qyryFqrW7CFW7ury5WrnYyw1j
        yr4Yqa4xZ34qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5UwpgACs7
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/18/2023 3:09 PM, Mimi Zohar wrote:
> On Wed, 2023-10-18 at 11:31 +0200, Roberto Sassu wrote:
>> On Tue, 2023-10-17 at 18:07 +0200, Roberto Sassu wrote:
>>> On Tue, 2023-10-17 at 11:58 -0400, Paul Moore wrote:
>>>> On Tue, Oct 17, 2023 at 3:01 AM Roberto Sassu
>>>> <roberto.sassu@huaweicloud.com> wrote:
>>>>> On Mon, 2023-10-16 at 11:06 -0400, Paul Moore wrote:
>>>>>> On Mon, Oct 16, 2023 at 8:05 AM Roberto Sassu
>>>>>> <roberto.sassu@huaweicloud.com> wrote:
>>>>>>>
>>>>>>> Sorry, I just noticed LSM_ID_IMA. Since we have the 'integrity' LSM, I
>>>>>>> think it should be LSM_ID_INTEGRITY.
>>>>>>>
>>>>>>> Mimi, all, do you agree? If yes, I send a patch shortly.
>>>>>>
>>>>>> I believe LSM_ID_IMA is the better option, despite "integrity" already
>>>>>> being present in Kconfig and possibly other areas.  "IMA" is a
>>>>>> specific thing/LSM whereas "integrity" is a property, principle, or
>>>>>> quality.  Especially as we move forward with promoting IMA as a full
>>>>>> and proper LSM, we should work towards referring to it as "IMA" and
>>>>>> not "integrity".
>>>>>>
>>>>>> If anything we should be working to support "IMA" in places where we
>>>>>> currently have "integrity" so that we can eventually deprecate
>>>>>> "integrity".
>>>>>
>>>>> Hi Paul
>>>>>
>>>>> I fully understand your argument. However, 'integrity' has been the
>>>>> word to identify the integrity subsystem since long time ago.
>>>>>
>>>>> Reducing the scope to 'ima' would create some confusion since, while
>>>>> 'ima' is associated to integrity, it would not encompass EVM.
>>>>
>>>> Using LSM_ID_IMA to reference the combination of IMA+EVM makes much
>>>> more sense to me than using LSM_ID_INTEGRITY, especially as we move
>>>> towards promoting IMA+EVM and adopting LSM hooks for integrity
>>>> verification, opening the door for other integrity focused LSMs.
>>>
>>> + Mimi, linux-integrity
>>>
>>> Ok, just to understand before posting v4, the code looks like this:
>>
>> I worked on a new proposal. Let me know what you think. It is available
>> here:
>>
>> https://github.com/robertosassu/linux/tree/ima-evm-lsms-v4-devel-v6
>>
>>
>> I made IMA and EVM as standalone LSMs and removed 'integrity'. They
>> maintain the same properties of 'integrity', i.e. they are the last and
>> always enabled.
>>
>> During initialization, 'ima' and 'evm' call integrity_iintcache_init(),
>> so that they can get integrity metadata. I added a check to ensure that
>> this function is called only once. I also added the lsmid parameter so
>> that the integrity-specific functions are added under the LSM ID of the
>> caller.
>>
>> I added a new LSM ID for EVM, does not look good that IMA and EVM are
>> represented by LSM_ID_IMA.
>>
>> Finally, I had to drop the patch to remove the rbtree, because without
>> the 'integrity' LSM, space in the security blob cannot be reserved.
>> Since integrity metadata is shared, it cannot be reserved by 'ima' or
>> 'evm'.
>>
>> An intermediate solution would be to keep the 'integrity' LSM just to
>> reserve space in the security blob. Or, we remove the rbtree if/when
>> IMA and EVM use disjoint integrity metadata.
> 
> One of the major benefits for making IMA and EVM LSMs was removing the
> rbtree and replacing it with the ability of using i_security.
> 
> I agree with Roberto.  All three should be defined: LSM_ID_INTEGRITY,
> LSM_ID_IMA, LSM_ID_EVM.

I did not try yet, but the 'integrity' LSM does not need an LSM ID. With 
the last version adding hooks to 'ima' or 'evm', it should be sufficient 
to keep DEFINE_LSM(integrity) with the request to store a pointer in the 
security blob (even the init function can be a dummy function).

Roberto

